require 'yaml'
require 'aws-sdk'

module Sploder
	class Upload
		def run (bucket, file, path, acl, key, secret)
			unless bucket && file
				puts "You must at least enter a bucket name and relative or absolute path to the file to upload."
				puts "USAGE: sploder --upload BUCKET_NAME FILE_NAME | Optional: -p S3_PATH -a ACL_POLICY"
				exit 1
			end

			unless acl
				acl = "public_read"
			end

			unless path
				path = ''
			end

			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)

			bucket = s3.buckets[bucket]
			unless bucket.exists?
				puts "Looks like that bucket does not exist in your account."
				puts "Would you like to create it?"
				puts "Just run 'sploder --create -n #{bucket}'"
				exit 1
			end

			basename = File.basename(file)
			upload = bucket.objects["#{path}#{basename}"]
			upload.write(:file => file, :acl => acl)
			puts "Uploaded #{file} to: "
			puts upload.public_url
		end
	end
end
