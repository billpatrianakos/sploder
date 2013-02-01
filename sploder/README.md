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
    $ cd sploder/sploder
    $ gem build sploder.gemspec
    $ gem install sploder-0.X.X.gem # Please change to the version of Sploder you've downloaded - 0.3.3 as of this writing

## Usage

The [official documentation is here](http://sploder.cleverlabs.info) and explains the usage more in depth.

### Setup & connect to S3

Before Sploder will do anything you need to give it access to your S3 account. This is really simple. Just run `sploder --setup` and Sploder will walk you through the rest. You'll need your AWS access key ID and secret key to use Sploder. The prompts look like this:

![Sploder setup wizard](https://webassets.s3.amazonaws.com/blog_posts/setup.gif "Sploder setup wizard in action")

Sploder saves your information in a hidden file called `.sploder` in your home (~/) directory whether you're on Windows, Linux, or Mac. If your AWS credentials ever change just run `--setup` again to give Sploder the new ones. Don't want Sploder to know your S3 credentials? Just delete the config file (`sudo rm ~/.sploder` - Sploder can't connect to S3 without this file though).

### Upload a file

Uploads are what Sploder was made for. In particular, it shines when it comes to being able to quickly share files from the command line. Give Sploder a bucket name and file and Sploder will upload it and return the URL where it can be accessed for easy sharing. If you don't want your files to have public-read permissions just change the ACL policy as explained below.

The `--upload` or `-u` flag take a maximum of 4 arguments. 2 are required and 2 are optional. 2 have flags and 2 don't. Here's an example using all options:

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

### Listing avilable buckets

`--list` or `-l` will return a list of your S3 buckets. Simple as that. No other flags or options here. Just a simple `sploder --list` or `sploder -l` will do the trick.

### Create a new bucket

`--create` or `-c` creates a new bucket within your account. If the bucket name is not available an error will be returned. The `--create` flag takes one other flag, the `--name or -n` flag. Usage is as follows:

```
sploder --create -n my-new-s3-bucket
```

If all went well Sploder will let you know the bucket has been created.

![Creating a bucket](http://sploder.cleverlabs.info/img/design/create.png "Creating a new bucket")

If you want to confirm your bucket has been created (I'm not sure why you wouldn't just trust Sploder) you can run `sploder --list` right after `--create` has finished.

### Deleting buckets

`--delete` or `-d` will delete a bucket along with everything in it. Because deleting a bucket is irreversible and deletes everything within it, I made it so that fat-fingering `-d` won't automatically destroy all your precious files and instead you'll have to confirm deletion. Running `sploder --delete` will start a prompt that will first ask you for the name of the bucket and then ask you to confirm that you're sure you really want to delete the bucket along with everything in it. Below is a screenshot of all 3 steps (running `-d`, typing in the bucket name, and confirming) after they've been completed:

![Sploder delete prompts](http://sploder.cleverlabs.info/img/design/delete.png "Sploder slows you down when deleting a bucket to reduce the chances of accidental deletion")

### Exploring bucket contents

`--explore` or `-e` invokes the bucket explorer feature. This feature is under heavy development and doesn't work. But I'm still shipping it because I know you're all smart enough to add on to the Sploder::Bucket class methods for exploring buckets to make it work. This is a feature that I want a lot so you can be sure I'll be adding this feature soon.

## Support

You can get support from these sources (in order of importance)

* The [official Sploder site](http://sploder.cleverlabs.info) has complete documentation for usage and is *the place* for all future updates, docs, release info, and everything else.

* You can run `sploder` to get help from the command line. Using `sploder --help` or `sploder -h` will give you more information too.

* The [wiki](https://github.com/billpatrianakos/sploder/wiki) will document basic usage. It's basically the same as this readme.

## Roadmap

The 1.0 release will contain the same features that the current 0.3.3 version contains plus full support for listing the contents of buckets and paths within buckets through the `--explore` command. I believe that a good tool serves its purpose then gets out of the way. Because of this, I don't plan to add any more features to Sploder after `--explore` is implemented and instead focus on improving the existing codebase. If you have a feature request and it's a good idea that fits with the philosophy of Sploder I'd be happy to implement it but right now I can't think of anything else you could want from a tool like this.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
