require 'aws-sdk'

module Sploder
	class Bucket
		def create (name, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)
			s3.buckets.create(name)
			puts "Bucket #{name} created"
		end

		def delete (bucket_name, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)
			bucket = s3.buckets[bucket_name]
			bucket.delete!
			puts "The bucket, #{bucket_name}, was deleted. Permanently."
		end

		# The following methods do nothing. They will in the future.
		def host_website (bucket_name, index, error, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)

			# Get the bucket
			bucket = s3.buckets[bucket_name]

			# Set default index and error documents
			unless index
				index = "index.html"
			end

			unless error
				error = "error.html"
			end

			bucket.configure_website do |cfg|
				cfg.index_document_suffix = index
				cfg.error_document_key = error
			end

			puts "All set! #{bucket_name} is now configured as a web host"
		end

		def end_hosting (bucket_name, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)

			# Get bucket
			bucket = s3.buckets[bucket_name]
			bucket.remove_website_configuration
			puts "Web hosting has been disabled for #{bucket_name}"
		end
	end
end
