# Gets the docker image of ruby 3.1.0 and lets us build on top of that
FROM ruby:3.1.0

# Install rails dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev

# create a folder in the docker container and go into that folder
ENV INSTALL_PATH /api
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

# Copy the Gemfile and Gemfile.lock from app root directory into the /myapp/ folder in the docker container
COPY Gemfile $INSTALL_PATH/Gemfile
COPY Gemfile.lock $INSTALL_PATH/Gemfile.lock

# Run bundle install to install gems inside the gemfile
RUN gem install bundler
RUN bundle install

# Copy rails app to Docker
COPY . $INSTALL_PATH
