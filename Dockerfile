FROM ruby:2.2

RUN gem install fluentd foreman && \
    gem install fluent-plugin-ua-parser fluent-plugin-geoip-filter

RUN mkdir -p /etc/fluent/plugins
COPY plugins /etc/fluent/plugins/

ENV DOCKER_GEN_VERSION 0.4.3

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz


COPY . /app/
WORKDIR /app/

ENV S3_REGION ap-northeast-1

EXPOSE 10224
EXPOSE 24224

CMD ["foreman", "start", "-r"]
