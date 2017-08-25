FROM ruby:2.4.0-slim
MAINTAINER Guillaume Hain zedtux@zedroot.org


# ~~~~ Set up the environment ~~~~
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /gem/
WORKDIR /gem
COPY Gemfile /gem
COPY *.gemspec /gem
COPY lib/cucumber/version.rb /gem/lib/cucumber/version.rb

# ~~~~ OS Maintenance & Rails Preparation ~~~~
# Rubygems and Bundler
RUN apt-get update && apt-get install -y git build-essential unzip

RUN touch ~/.gemrc && echo "gem: --no-ri --no-rdoc" >> ~/.gemrc

RUN gem install rubygems-update && update_rubygems

RUN gem install bundler && bundle install

RUN apt-get remove --purge -y build-essential && \
  apt-get autoclean -y && \
  apt-get clean

# Import the gem source code
COPY . /gem

ENTRYPOINT ["bundle", "exec"]
CMD ["rake", "-T"]
