FROM ubuntu:14.04

RUN apt-get update -qq

# Environments
# - Language
RUN apt-get install -y debconf sudo apt-utils locales
RUN locale-gen --purge en_US.UTF-8
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"
RUN dpkg-reconfigure --frontend=noninteractive locales
# RUN update-locale LANG="en_US.UTF-8"

# ------------------------------------------------------
# --- Pre-installed but not through apt-get

# install Ruby from source
#  from source: mainly because of GEM native extensions,
#  this is the most reliable way to use Ruby no Ubuntu if GEM native extensions are required
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev
RUN wget -q http://cache.ruby-lang.org/pub/ruby/ruby-2.3.1.tar.gz
RUN tar -xvzf ruby-2.3.1.tar.gz
RUN cd ruby-2.3.1 && ./configure --prefix=/usr/local && make && make install
# cleanup
RUN rm -rf ruby-2.3.1
RUN rm ruby-2.3.1.tar.gz

RUN gem install bundler --no-document

# NodeJS
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get update -qq && apt-get install -y nodejs libfontconfig

# PhantomJS
RUN npm install -g phantomjs@1.9
