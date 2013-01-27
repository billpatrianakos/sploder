#! /usr/bin/env ruby
require 'optparse'
require 'aws-sdk'

bucket = ARGV[0]
file = ARGV[1]
path = ARGV[2]
acl = ARGV[3]

# TODO: Add ACL
# Canned ACLs:
# private, public_read, public_read_write, authentication_read, bucket_owner_read,
unless bucket && file
	puts "Usage: uppit <BUCKET_NAME> <FILE_NAME>"
	exit 1
end

unless acl
	acl = "public_read"
end

unless path
	path = ''
end

s3 = AWS::S3.new(
	:access_key_id => 'KEY_HERE',
	:secret_access_key => 'SECRET_HERE')

# Create a bucket

# Use existing bucket
bucket = s3.buckets[bucket]

basename = File.basename(file)
upload = bucket.objects["#{path}/#{basename}"]
upload.write(:file => file, :acl => acl)
puts "Uploaded #{file} to: "
puts upload.public_url

# List buckets
# s3.buckets.each do |bucket|
#	puts bucket.name
# end

exit 0
