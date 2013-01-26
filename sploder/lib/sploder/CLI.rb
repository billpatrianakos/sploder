require 'thor'
require 'sploder'
require 'sploder/upload'

module Sploder
	class CLI < Thor
		desc "upload BUCKET, FILE, PATH, ACL", "Uploads a file to S3"
		# method_option :bucket, :type => :string, :desc => 'S3 bucket'
		# method_option :file, :type => :string, :desc => 'File to upload'
		# method_option :path, :type => :string, :desc => 'Optional directory within your bucket to upload to'
		# method_option :acl, :type => string, :desc => 'Optional ACL policy (defaults to public-read)'
		def upload(bucket, file, path, acl)
			puts "#{bucket} and #{file} and #{path} and #{acl}"
		end

		desc "run", "Runs the Gem"
		def hey
			puts "running"
		end
	end
end
