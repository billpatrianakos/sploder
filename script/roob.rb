#! /usr/bin/env ruby
require 'optparse'
require 'aws-sdk'

#--- Options ---#
options = {}

opt_parser = OptionParser.new do |opt|
	opt.banner 		= "Usage: sploder <COMMAND> [OPTIONS]"
	opt.separator 	""
	opt.separator 	"Commands"
	opt.separator 	"  upload: Upload a file to S3"
	opt.separator 	"    Usage: sploder upload [BUCKET_NAME] [FILE] Optional: [BUCKET_PATH] [ACL]"
	opt.separator 	"  create: Creates a new S3 bucket"
	opt.separator 	"    Usage: sploder create [BUCKET_NAME]"
	opt.separator 	"  list: Lists your buckets and files"
	opt.separator 	""
	opt.separator 	"Options"

	opt.on("-e","--environment ENVIRONMENT","which environment you want server run") do |environment|
		options[:environment] = environment
	end

	opt.on("-d","--daemon","runing on daemon mode?") do
		options[:daemon] = true
	end

	opt.on("-h","--help","help") do
		puts opt_parser
	end
end

opt_parser.parse!

puts opt_parser

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
	:access_key_id => 'AKIAJ3YMT6TGLY7YUW6A',
	:secret_access_key => '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')

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
