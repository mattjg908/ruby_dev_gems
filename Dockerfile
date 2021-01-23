FROM ruby:2.1

# create Gemfile
RUN echo "source 'https://rubygems.org'\n\ngem 'reek'\ngem 'flog' \ngem 'rubocop', require: false" >> Gemfile
RUN bundle install
