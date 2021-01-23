FROM ruby:latest

# create Gemfile
RUN echo "source 'https://rubygems.org'\n\ngem 'reek'\ngem 'flog' \ngem 'rubocop', require: false" >> Gemfile
RUN bundle install
