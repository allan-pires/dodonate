FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /dodonate
WORKDIR /dodonate
COPY Gemfile /dodonate/Gemfile
COPY Gemfile.lock /dodonate/Gemfile.lock
RUN bundle install
COPY . /dodonate