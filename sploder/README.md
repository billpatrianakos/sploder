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

`--explore` or `-e` invokes the bucket explorer feature. This operation requires you to use the `-n` or `--name` flag to specify which bucket you want to explore. Using it with only a bucket name will show you a complete list of all files in all subfolders in your S3 bucket. Depending on how many files you have stored this could be a real lot of output. Unless you have small buckets you may want to use it with the prefix (`--prefix` or `-r`) flags to narrow down your search.

To see files and folders within a specified directory you'd use the `--prefix` flag as described above. You can explore as many levels deep as you want. See examples below for more.

__Examples__

*Explore the entire contents of a bucket:*

```
$ sploder --explore -n mybucket
# Sample output below
Sploder is sploding...
fileinroot.txt
blog_posts/
blog_posts/my_image.jpg
blog_posts/2013/
blog_posts/2013/january/image1.png
photos/
photos/shot1.jpg
```

The important thing to notice in the above example is that not specifying a specific bucket prefix, or directory path as we know them, S3 returns a list of every single file, folder, and their contents no matter how many levels deep they go.

*Exploring a specific directory within your bucket: (uses the `--prefix` or `-r` flags)* 

```
$ sploder --explore -n mybucket -r blog_posts
Sploder is sploding...
blog_posts/file1.txt
blog_posts/file2.png
blog_posts/2013/
blog_posts/2013/photo.gif
blog_posts/2013/january/
blog_posts/2013/january/file.ext
```

The important thing to notice from the above example is thatS3 returns a list of every last file and folder plus their contents when you specify a prefix.

Whenever possible, be as specific as possible when exploring the contents of your buckets. The broader your search, the more results Sploder returns, and the harder to sort they may be. For most people this is not a problem but if you have very large number of files and paths within a bucket then please be aware of this and explore your buckets accordingly.

*Being specific when exploring a bucket:*

```
$ sploder --explore -n mybucket -r photos/2013/family_photos
Sploder is sploding...
photos/2013/family_photos/mom/
photos/2013/family_photos/dad/being-silly.jpg
```

Obviously this is a made up example but the point is that being more specific will return less results and make it easier for you to manage your results.

### Getting file URLs

You can get the public URL of a previously uploaded file using the `--file` flag. The `--file` operation takes up to 3 arguments all of which do not have their own flags. The following example has 2 parts. The first part lists the contents of a bucket to search for a particular file. The second part uses the output to get that file's URL. If you already know the path within S3 to the file you want you can skip part 1.

__Part 1: Search for file__

```
sploder --explore -n mybucket -r photos
# Outputs:
Sploder is sploding...
photos/me.jpg
photos/hawaii/
...
```

Here we have a few files to choose from. For this example we'll use 'me.jpg'.

__Part 2: Get the public URL of a given file__

```
sploder --file mybucket photos/me.jpg
# Outputs:
Sploder is sploding...
Your file's public URL:
https://mybucket.s3.amazonaws.com/photos/me.jpg
```

### Deleting a file

Deleting a file also uses the `--file` or `-f` flag. It's similar to getting the public URL with one extra paramter. All arguments passed to `--file` need to be in this exact order or they will not work: bucket name, file path within S3, and the optional operation (currently only 'delete' is supported).

Example: In this example we'll use the file from our previous example of getting public URLs

```
sploder --file mybucket photos/me.jpg delete
# Output
Sploder is sploding...
Deleted photos/me.jpg from mybucket
```

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
