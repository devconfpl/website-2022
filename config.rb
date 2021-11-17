# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions
#
activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

data.speakers.each do |s|
  proxy "/speakers/#{s.tag}/index.html", "/person_template.html", :locals => { :person => s }, :ignore => true
end

data.program_committee.each do |pc|
  proxy "/program-committee/#{pc.tag}/index.html", "/person_template.html", :locals => { :person => pc }, :ignore => true
end

data.workshops.items.each do |w|
  proxy "/workshops/#{w.tag}/index.html", "/workshops/template.html", :locals => { :workshop => w }, :ignore => true
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def utm_link url 
    url + "?utm_source=devconf"
  end

  def twitter_link handle
    'https://twitter.com/' + handle
  end

  def linkedin_link handle
    'https://www.linkedin.com/in/' + handle + '/'
  end

  def js_link name, ver
    '<script src="/javascripts/' + name + '.js?v=' + ver + '"></script>'
  end

  def css_link name, ver 
    '<link href="/stylesheets/' + name + '.css?v=' + ver + '" rel="stylesheet">'
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
#
## Configuration code for Middleman AWS S3 Sync
# See middleman-s3_sync documentation: https://github.com/fredjean/middleman-s3_sync
activate :s3_sync do |s3_sync|
  # The name of the S3 bucket you are targeting. This is globally unique.
  s3_sync.bucket                     = ENV['AWS_S3_BUCKET_NAME']
  # The AWS region code for your bucket.
  # For region codes: http://www.bucketexplorer.com/documentation/amazon-s3--amazon-s3-buckets-and-regions.html
  s3_sync.region                     = ENV['AWS_REGION']
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY_ID']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_KEY']
  #s3_sync.delete                     = true # We delete stray files by default.
  #s3_sync.after_build                = true # We do not chain after the build step by default.
end

# CloudFront cache invalidation

activate :cdn do |cdn|
  cdn.cloudfront = {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],           # default ENV['AWS_ACCESS_KEY_ID']
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],       # default ENV['AWS_SECRET_ACCESS_KEY']
    distribution_id: ENV['PRODUCTION_CLOUDFRONT_DISTRIBUTION_ID']
  }
end
