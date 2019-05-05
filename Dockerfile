FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /verspaetung-public-transport
WORKDIR /verspaetung-public-transport
COPY Gemfile /verspaetung-public-transport/Gemfile
COPY Gemfile.lock /verspaetung-public-transport/Gemfile.lock
RUN bundle install
COPY . /verspaetung-public-transport

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8081

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]