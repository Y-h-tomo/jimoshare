FROM ruby:2.6.6
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN mkdir /jimoshare
WORKDIR /jimoshare

ADD Gemfile /jimoshare/Gemfile
ADD Gemfile.lock /jimoshare/Gemfile.lock

RUN gem install bundler:2.1.4
RUN bundle install

ADD . /jimoshare

# Nginxと通信を行うための準備
RUN mkdir -p tmp/sockets
VOLUME /jimoshare/public
VOLUME /jimoshare/tmp

RUN yarn install --check-files
RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile