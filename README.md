### Building
This site is generated using [Middleman](https://middlemanapp.com/).
All instruction how to install Middleman and build the site are available on Middleman page. In the minimalistic version it would be:

installation:
``` shell
gem install middleman
bundle install
```
building site:
``` shell
middleman build
```

### CI on CircleCI
CircleCI uses docker image `mihcall/devconf-middleman` which contains:
  - ruby 2.6
  - nodejs
  - middleman
  - bundler 2.0.1
  - gems specified in Gemfile

It then builds the project, updates it on S3 and invalidates CloudFront cache.

Adding gems, changing ruby/bundler version etc. should land in the docker image for CircleCI flow to work properly.
