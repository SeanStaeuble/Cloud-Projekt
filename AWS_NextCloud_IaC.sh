#!/bin/bash
set -e

# ==============================
# GRUNDKONFIGURATION
# ==============================
REGION="us-east-1"

AMI_ID="ami-0c02fb55956c7d316"   # Amazon Linux 2 (us-east-1)
INSTANCE_TYPE="t3.micro"
KEY_NAME="vockey"

# Security Groups
SG_EC2_NAME="SG_Nextcloud_EC2"
SG_RDS_NAME="SG_Nextcloud_RDS"

# RDS
DB_IDENTIFIER="nextcloud-db"
DB_NAME="nextcloud"
DB_USER="ncuser"
DB_PASS="Nextcloud123!"
DB_CLASS="db.t3.micro"

# ==============================
# SECURITY GROUP FÜR EC2
# ==============================
echo "🔐 Erstelle Security Group für EC2 (Webserver)..."

SG_EC2_ID=$(aws ec2 create-security-group \
  --region $REGION \
  --group-name "$SG_EC2_NAME" \
  --description "Security Group for Nextcloud EC2" \
  --query GroupId \
  --output text)

aws ec2 authorize-security-group-ingress --region $REGION --group-id $SG_EC2_ID --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --region $REGION --group-id $SG_EC2_ID --protocol tcp --port 80 --cidr 0.0.0.0/0

# ==============================
# SECURITY GROUP FÜR RDS
# ==============================
echo "🗄 Erstelle Security Group für RDS (Datenbank)..."

SG_RDS_ID=$(aws ec2 create-security-group \
  --region $REGION \
  --group-name "$SG_RDS_NAME" \
  --description "Security Group for Nextcloud RDS" \
  --query GroupId \
  --output text)

aws ec2 authorize-security-group-ingress \
  --region $REGION \
  --group-id $SG_RDS_ID \
  --protocol tcp \
  --port 3306 \
  --source-group $SG_EC2_ID

# ==============================
# RDS MYSQL ERSTELLEN
# ==============================
echo "🗄 Erstelle RDS MySQL Datenbank..."

aws rds create-db-instance \
  --region $REGION \
  --db-instance-identifier "$DB_IDENTIFIER" \
  --db-instance-class "$DB_CLASS" \
  --engine mysql \
  --allocated-storage 20 \
  --master-username "$DB_USER" \
  --master-user-password "$DB_PASS" \
  --db-name "$DB_NAME" \
  --vpc-security-group-ids "$SG_RDS_ID" \
  --publicly-accessible \
  --backup-retention-period 0

echo "⏳ Warte, bis die RDS-Datenbank verfügbar ist..."
aws rds wait db-instance-available \
  --region $REGION \
  --db-instance-identifier "$DB_IDENTIFIER"

DB_ENDPOINT=$(aws rds describe-db-instances \
  --region $REGION \
  --db-instance-identifier "$DB_IDENTIFIER" \
  --query "DBInstances[0].Endpoint.Address" \
  --output text)

echo "✅ RDS ist verfügbar unter:"
echo "   $DB_ENDPOINT"

# ==============================
# USER-DATA (EC2 KONFIGURATION)
# ==============================
USER_DATA=$(base64 <<EOF
#!/bin/bash
yum update -y
amazon-linux-extras enable php8.1
yum install -y httpd php php-mysqlnd php-gd php-curl php-mbstring php-xml php-zip php-intl unzip wget

systemctl start httpd
systemctl enable httpd

cd /tmp
wget https://download.nextcloud.com/server/releases/latest.zip
unzip latest.zip
mv nextcloud /var/www/html/
chown -R apache:apache /var/www/html/nextcloud

sleep 30

sudo -u apache php /var/www/html/nextcloud/occ maintenance:install \
 --database mysql \
 --database-host "$DB_ENDPOINT" \
 --database-name "$DB_NAME" \
 --database-user "$DB_USER" \
 --database-pass "$DB_PASS" \
 --admin-user "administrator" \
 --admin-pass "nextcloud2!"
EOF
)

# ==============================
# EC2 INSTANZ ERSTELLEN
# ==============================
echo "🖥 Erstelle EC2 Instanz (Nextcloud Webserver)..."

INSTANCE_ID=$(aws ec2 run-instances \
  --region $REGION \
  --image-id "$AMI_ID" \
  --instance-type "$INSTANCE_TYPE" \
  --key-name "$KEY_NAME" \
  --security-group-ids "$SG_EC2_ID" \
  --user-data "$USER_DATA" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Nextcloud-Server}]" \
  --query "Instances[0].InstanceId" \
  --output text)

# ==============================
# AUSGABE
# ==============================
echo "===================================="
echo "✅ Deployment abgeschlossen"
echo ""
echo "🌐 Nextcloud aufrufen:"
echo "http://<EC2-PUBLIC-IP>/nextcloud"
echo ""
echo "👤 Administrationskonto:"
echo "Benutzername: administrator"
echo "Passwort:     nextcloud2!"
echo ""
echo "🗄 Datenbank (MySQL / MariaDB auswählen):"
echo "Datenbank-Benutzer:  ncuser"
echo "Datenbank-Passwort: Nextcloud123!"
echo "Datenbank-Name:     nextcloud"
echo "Datenbank-Host:     $DB_ENDPOINT:3306"
echo ""
echo "📁 Datenordner:"
echo "/var/www/html/nextcloud/data"
echo "===================================="