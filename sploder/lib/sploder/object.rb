require 'aws-sdk'

module Sploder
	class Object
		def get_url (bucket_name, file, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)

			bucket = s3.buckets[bucket_name].objects[file]
			puts "Your file's public url:"
			puts bucket.public_url
		end

		def download_file (bucket_name, file, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)

			puts "Download function is not available in Sploder stable versions currently."
			puts "You can download the latest edge version from http://sploder.cleverlabs.info"
		end

		def delete_file (bucket_name, file, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)

			bucket = s3.buckets[bucket_name].objects[file]
			bucket.delete
			puts "Deleted #{file} from #{bucket_name}"
		end
	end
end