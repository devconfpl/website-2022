FROM ruby:2.6

ENV LANG C.UTF-8
RUN apt-get update -y \
	&& curl -sL https://deb.nodesource.com/setup_12.x | bash - \
	&& apt-get install -y nodejs

RUN gem install bundler:2.0.1

WORKDIR /app

COPY Gemfile Gemfile.lock config.rb ./
COPY source ./source
COPY data ./data

RUN bundle install
