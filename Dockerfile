FROM ruby:3.0-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    build-essential libpq-dev libsqlite3-dev \
    postgresql-client nodejs npm
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN npm install --global yarn

WORKDIR /myapp
COPY Gemfile* /myapp/
RUN bundle config set --local without 'development test'
RUN bundle install --jobs 5
RUN yarn install

COPY package*.json /myapp/
RUN yarn install

# Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]

COPY . /myapp/
EXPOSE 3000

CMD foreman run web
