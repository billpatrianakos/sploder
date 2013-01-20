# Sploder (The S3 Uploader)

*__NOTICE: This gem is in very early alpha stage. Feel free to use it as a reference for your own work but it's not ready for primetime. The 'roob.rb' file in the scripts folder, however, is capable of uploading files to S3 current.*__

Sploder is a Ruby Gem whose main purpose is to upload files to Amazon S3. Them gem also lets you do all sorts of cool things like creating new buckets, listing buckets and files, setting ACL policies, and more.

## Installation

Coming soon.

## Usage

### Uploading files

Given a file, bucket name, and optional bucket path Sploder will upload the file to the bucket and path within the bucket specified and return the URL of your file.

Example:
`sploder upload ~/Documents/myfile.pdf myBucket pdfs/2013`