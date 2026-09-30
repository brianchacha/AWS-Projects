require 'bundler/setup'
require 'aws-sdk-s3'

# 1. Explicitly bind your personal credentials to bypass Gitpod's lab settings
s3 = Aws::S3::Resource.new(
  region: 'eu-north-1',
  access_key_id: 'PASTE_YOUR_PERSONAL_AKIA_KEY_HERE',
  secret_access_key: 'PASTE_YOUR_PERSONAL_SECRET_KEY_HERE'
)

# 2. Prompt the user for a custom bucket name
print "Enter a custom name for your new S3 bucket: "
bucket_name = gets.chomp # Captures terminal text input and strips trailing newlines

# Standard validation check to prevent empty string submission
if bucket_name.strip.empty?
  puts "❌ Error: Bucket name cannot be blank."
  exit 1
end

puts "Initiating bucket creation for: #{bucket_name}..."

begin
  bucket = s3.bucket(bucket_name)
  bucket.create(
    create_bucket_configuration: {
      location_constraint: 'eu-north-1'
    }
  )
  puts "🚀 Success! S3 Bucket '#{bucket_name}' has been created in eu-north-1."

rescue Aws::S3::Errors::BucketAlreadyExists => e
  puts "❌ Error: The bucket name '#{bucket_name}' is already taken globally. Choose a different name."
rescue Aws::S3::Errors::BucketAlreadyOwnedByYou => e
  puts "ℹ️ Notice: You already own a bucket named '#{bucket_name}' in this account."
rescue Aws::S3::Errors::ServiceError => e
  puts "❌ AWS API Error: #{e.message}"
end
