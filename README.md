# Sploder (The S3 Uploader)

*__NOTICE: This gem is in very early alpha stage. It works but is poorly documented.*__

Sploder is a CLI Ruby Gem whose main purpose is to upload files to Amazon S3. Them gem also lets you do all sorts of cool things like creating new buckets, listing buckets and files, setting ACL policies, and more.

## Installation

Coming soon.

## Usage

### Uploading files

Given a file, bucket name, and optional bucket path Sploder will upload the file to the bucket and path within the bucket specified and return the URL of your file.

Example:
`sploder --upload myBucket ~/Documents/myfile.pdf pdfs/2013`
