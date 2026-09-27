#!/usr/bin/pwsh

# 1. Enforce argument input validation
if ($null -eq $args[0] -or $args[0] -eq "") {
    Write-Error "Error: Missing argument. Usage: .\delete-bucket.ps1 <bucket-name>"
    exit 1
}

$BucketName = $args[0]

Write-Host "Removing S3 Bucket '$BucketName'..."

# 2. Delete the bucket natively
# Using -Force bypasses confirmation prompts. 
# Note: The bucket must still be completely empty of all files.
Remove-S3Bucket -BucketName $BucketName -Force
