# Sploder

Sploder is the S3 uploader. It is meant to help you perform a handful of common operations with S3 quickly, without ever having to leave the command line.

## Installation

Add this line to your application's Gemfile:

    gem 'sploder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sploder

Or manually with

    $ git clone https://github.com/billpatrianakos/sploder.git
    cd sploder/sploder
    gem build sploder.gemspec
    gem install sploder-0.X.X.gem # Please change to the version of Sploder you've downloaded - 0.3.3 as of this writing

## Usage

The [official documentation is here](http://sploder.cleverlabs.info)

### Setup & connect to S3

Before Sploder will do anything you need to give it access to your S3 account. This is really simple. Just run `sploder --setup` and Sploder will walk you through the rest. You'll need your AWS access key ID and secret key to use Sploder. The prompts look like this:

![Sploder setup wizard](https://webassets.s3.amazonaws.com/blog_posts/setup.gif "Sploder setup wizard in action")

Sploder saves your information in a hidden file called `.sploder` in your home (~/) directory whether you're on Windows, Linux, or Mac. If your AWS credentials ever change just run `--setup` again to give Sploder the new ones. Don't want Sploder to know your S3 credentials? Just delete the config file (`sudo rm ~/.sploder` - Sploder can't connect to S3 without this file though).

### Upload a file

The `--upload / -u` flag take a maximum of 4 arguments. 2 are required and 2 are optional. 2 have flags and 2 don't. Here's an example using all options:

```
sploder --upload mybucket path/to/myfile.ext -p testing/somefolder -a private
```

The first two arguments after the `--upload` flag are the name of your bucket and the path to the file you want to upload. They are required and must come in that order.

`-p`, also known as `--path` is the path *within your S3 bucket* you want your file uploaded to. So if you uploaded a photo and wanted it to go into `yourbucketurl/2013/photos/` then you'd use the `-p` flag and write `2013/photos/`. The path argument is optional. If you do use it, remember that __your path must not have a leading slash and must have a trailing slash__. Sploder will accept paths with a leading slash and no trailing slash because S3 allows them but you'll end up with some weird final paths like `https://mybucket.amazonaws.com//foldermyfile.ext`. And it'll work! But it's not good for organization.

`-a` or `--acl` is the ACL policy you want to give the file you're uploading. This flag is optional and defaults to *public_read*. Sploder accepts the following ACL policies:

* __public_read__ (Default, no need to specify an ACL if you want this)

* __private__ - Only you can access the file

* __public_read_write__ - This is dumb. Don't do this unless you know what you're doing. The whole world can read and write to your file.

* __authenticated_read__ - Only logged in users can read the file? See the AWS docs to know for sure.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
