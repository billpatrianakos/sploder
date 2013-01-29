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
	end
end
