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

		def list_bucket (key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)
			tree = s3.objects.with_prefix('photos').as_tree
			directories = tree.children.select(&:branch?).collect(&:prefix)
		end

		def create_bucket (name, key, secret)
			s3 = AWS::S3.new(
				:access_key_id => key,
				:secret_access_key => secret)
			s3.bucket.create(name)
			puts "Bucket #{name} created"
		end
	end
end
