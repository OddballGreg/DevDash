FROM ruby:2.5-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata yarn

ENV INSTALL_PATH /app/devdash
ENV RAILS_ENV production

ENV TZ=Africa/Johannesburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

ADD Gemfile $INSTALL_PATH/Gemfile
ADD Gemfile.lock $INSTALL_PATH/Gemfile.lock

RUN bundle install

COPY . .
