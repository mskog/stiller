FROM ruby:2.2.0
RUN apt-get update && apt-get -y install ffmpegthumbnailer

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

EXPOSE 8080
CMD bundle exec rackup -s Puma -p 8080 --host 0.0.0.0
