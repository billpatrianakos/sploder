# Sploder (The S3 Uploader)

__Full docs available from [the official website](http://sploder.cleverlabs.info)__

Sploder is a CLI Ruby Gem whose main purpose is to upload files to Amazon S3. Them gem also lets you do all sorts of cool things like creating new buckets, listing buckets and files, setting ACL policies, and more.

Sploder was born from a really simple Ruby script which isn't updated anymore but is in this repo for (my own selfish) historical reasons. The Gem source and its documentation are within the `sploder` folder.

## Installation

`gem install sploder`

or use the source...

```
git clone https://github.com/billpatrianakos/sploder.git
cd sploder/sploder # That's right, you have to go into the second sploder folder
gem build sploder.gemspec
gem install sploder-0.3.3.gem # Version will change in the future. Please check what gem build gives you and use that
```

## Usage

### Using the script

The script is deprecated but it works. Open it up, put in your S3 credentials, and then use it like...

```
ruby /path/to/roob.rb bucketname filepath path/within/s3 acl_policy
# path/within/s3 and acl_policy are optional
```

### Using the gem

```
sploder --upload mybucket ~/Documents/kitties.jpg
Sploder is sploding...
Your file, kitties.jpg, was uploaded to:
https://mybucket.s3.amazonaws.com/kitties.jpg
```

For the full list of functions, flags, and options see the `/sploder` folder.

[Official documentation here](http://sploder.cleverlabs.info)
