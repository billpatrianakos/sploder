require 'aws-sdk'

module Sploder
	class List
		def default (key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)
			s3.buckets.each do |bucket|
				puts bucket.name
			end
		end
	end
end
