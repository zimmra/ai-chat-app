
FROM alpine:3.15

ENV LANG="C.UTF-8" \
    PS1="$(whoami)@$(hostname):$(pwd)$ " \
    TERM="xterm-256color"

# COPY app/package.json /usr/src/app/
# COPY app/yarn.lock /usr/src/app/

COPY . /app
COPY entrypoint.sh /run/
WORKDIR /app

# TODO: replace custom repository when yarn is no longer in edge/community
RUN apk add yarn --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

RUN chmod 777 /app && \
    mv /app/.env.example /app/.env && \
    chmod 777 /run && \
    chmod +x /run/entrypoint.sh

RUN yarn install && \
    yarn prisma migrate deploy && \
    yarn build

RUN \
    mkdir -p /config && \
    chmod 777 /config

VOLUME /app
VOLUME /config

EXPOSE 3000

ENTRYPOINT ["/run/entrypoint.sh"]