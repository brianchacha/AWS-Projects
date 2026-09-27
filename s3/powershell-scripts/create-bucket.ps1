#!/usr/bin/pwsh

# 1. Enforce that a bucket name argument is provided
if ($null -eq $args[0] -or $args[0] -eq "") {
    Write-Error "Error: Please provide a bucket name. Usage: .\create-bucket.ps1 <bucket-name>"
    exit 1
}

$BucketName = $args[0]
$Region = "eu-north-1"

Write-Host "Creating S3 Bucket '$BucketName' in region '$Region' natively..."

# 2. Execute the native object-oriented AWS Cmdlet
# New-S3Bucket automatically handles location configuration mappings seamlessly.
New-S3Bucket -BucketName $BucketName -Region $Region
