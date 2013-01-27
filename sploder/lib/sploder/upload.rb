require 'yaml'
require 'aws-sdk'

module Sploder
	class Upload
		def run (bucket, file, path, acl, key, secret)
			unless bucket && file
				puts "Usage: sploder <BUCKET_NAME> <FILE_NAME> | Optional: <S3_PATH> <ACL_POLICY>"
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
			basename = File.basename(file)
			upload = bucket.objects["#{path}/#{basename}"]
			upload.write(:file => file, :acl => acl)
			puts "Uploaded #{file} to: "
			puts upload.public_url
		end

		def load_settings
			settings_file = File.expand_path('.sploder', '~')
			settings = YAML.load_file(settings_file)
			return settings
		end
	end
end
