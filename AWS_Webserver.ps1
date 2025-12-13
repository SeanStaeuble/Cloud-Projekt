# Voraussetzung: aws cli ist installiert und konfiguriert (aws configure)

# 1) Keypair erstellen und unter ~/.ssh speichern
$sshDir = Join-Path $HOME ".ssh"
if (!(Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir | Out-Null
}

$UserFolder = Split-Path $env:USERPROFILE -Leaf
$KeyName    = "AWS_KEY_$UserFolder"
$keyFile    = Join-Path $sshDir "$KeyName.pem"

Write-Host "Verwende KeyName (AWS & EC2): $KeyName"
Write-Host "Der Pfad zum Schluessel lautet: $keyFile"

# vorhandenes Keypair in AWS löschen (falls existiert)
aws ec2 delete-key-pair --key-name $KeyName 2>$null

# lokale Datei löschen (falls existiert)
if (Test-Path $keyFile) {
    Remove-Item $keyFile
}

aws ec2 create-key-pair `
    --key-name $KeyName `
    --key-type rsa `
    --query 'KeyMaterial' `
    --output text | Out-File -Encoding ascii -FilePath $keyFile

Write-Host "Keypair $KeyName erstellt und in $keyFile gespeichert."

# 2) Security Group idempotent anlegen
$SecGroupName = "sec-group-$UserFolder"

# vorhandene Security Group löschen (nur per Name in Default-VPC möglich)
aws ec2 delete-security-group --group-name $SecGroupName 2>$null   # Default-VPC[web:78]

aws ec2 create-security-group `
    --group-name $SecGroupName `
    --description "EC2-Webserver-SG"

aws ec2 authorize-security-group-ingress `
    --group-name $SecGroupName `
    --protocol tcp --port 80 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress `
    --group-name $SecGroupName `
    --protocol tcp --port 22 --cidr 0.0.0.0/0

Write-Host "Security Group $SecGroupName erstellt und Ports 22/80 freigeschaltet."

# 3) Verzeichnis und initial.txt (user-data) erstellen
$webDir = Join-Path $HOME "ec2webserver"
if (!(Test-Path $webDir)) {
    New-Item -ItemType Directory -Path $webDir | Out-Null
}

$initFile = Join-Path $webDir "initial.txt"

@("#!/bin/bash",
"sudo apt-get update",
"sudo apt-get -y install apache2") | Out-File -Encoding ascii -FilePath $initFile

Write-Host "Init-Skript initial.txt in $webDir erstellt."

# 4) EC2-Instanz starten
$runResult = aws ec2 run-instances `
    --image-id ami-08c40ec9ead489470 `
    --count 1 `
    --instance-type t2.micro `
    --key-name $KeyName `
    --security-groups $SecGroupName `
    --iam-instance-profile Name=LabInstanceProfile `
    --user-data file://$initFile `
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Webserver}]" `
    --query "Instances[0].InstanceId" `
    --output text

$instanceId = $runResult.Trim()
Write-Host "EC2-Instanz gestartet. InstanceId: $instanceId"

# 5) Statusabfrage (InstanceId, Public IP, State)
Write-Host "Aktueller Status der Instanz:"
aws ec2 describe-instances `
    --instance-ids $instanceId `
    --query "Reservations[*].Instances[*].{InstanceId:InstanceId, PublicIP:PublicIpAddress, State:State.Name}"
