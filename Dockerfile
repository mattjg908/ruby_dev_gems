FROM ruby:latest

# create Gemfile
RUN echo "source 'https://rubygems.org'\n\ngem 'reek'\ngem 'flog'" >> Gemfile
RUN bundle install
