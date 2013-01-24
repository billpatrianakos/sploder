#! /usr/bin/env ruby
require 'aws-sdk'

bucket = ARGV[0]
file = ARGV[1]
path = ARGV[2]

# TODO: Add ACL
# Canned ACLs:
# private, public_read, public_read_write, authentication_read, bucket_owner_read,

unless bucket && file
	puts "Usage: uppit <BUCKET_NAME> <FILE_NAME>"
	exit 1
end

unless path
	path = ''
end

s3 = AWS::S3.new(
	:access_key_id => 'AKIAJ3YMT6TGLY7YUW6A',
	:secret_access_key => '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')

# Create a bucket

# Use existing bucket
bucket = s3.buckets[bucket]

basename = File.basename(file)
upload = bucket.objects["#{path}/#{basename}"]
upload.write(:file => file, :acl => :public_read)
puts "Uploaded #{file} to: "
puts upload.public_url

# List buckets
# s3.buckets.each do |bucket|
#	puts bucket.name
# end

exit 0
