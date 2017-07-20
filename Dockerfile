FROM ubuntu:14.04

RUN apt-get update -qq

# Environments
# - Language
RUN apt-get install -y \
    debconf \
    sudo \
    apt-utils \
    locales \
 && locale-gen --purge en_US.UTF-8


# Environments
# - Language
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
# Tool versions
    TOOL_VER_RUBY="2.4.1" \
    TOOL_VER_NODEJS="4"

RUN dpkg-reconfigure --frontend=noninteractive locales
# RUN update-locale LANG="en_US.UTF-8"

# Essentials
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential \
    wget \
    curl \
    libpq-dev

# ------------------------------------------------------
# --- Pre-installed but not through apt-get

# install Ruby from source
#  from source: mainly because of GEM native extensions,
#  this is the most reliable way to use Ruby on Ubuntu if GEM native extensions are required
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential \
    zlib1g-dev \
    libssl-dev \
    libreadline6-dev \
    libyaml-dev \
    libsqlite3-dev \
 && mkdir -p /tmp/ruby-inst \
 && cd /tmp/ruby-inst \
 && wget -q http://cache.ruby-lang.org/pub/ruby/ruby-${TOOL_VER_RUBY}.tar.gz \
 && tar -xvzf ruby-${TOOL_VER_RUBY}.tar.gz \
 && cd ruby-${TOOL_VER_RUBY} \
 && ./configure --prefix=/usr/local && make && make install \
# cleanup
 && cd / \
 && rm -rf /tmp/ruby-inst

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_${TOOL_VER_NODEJS}.x | sudo -E bash -
RUN apt-get update -qq && apt-get install -y nodejs libfontconfig


# ------------------------------------------------------
# --- Tools installed through Ruby gems, NPM, ...

# PhantomJS
RUN npm install -g phantomjs@1.9
RUN gem install bundler --version "=1.12.4" --no-document
