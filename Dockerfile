
FROM alpine:3.15

ENV LANG="C.UTF-8" \
    PS1="$(whoami)@$(hostname):$(pwd)$ " \
    TERM="xterm-256color"

# COPY app/package.json /usr/src/app/
# COPY app/yarn.lock /usr/src/app/
COPY /app /app/ai-chat-app
COPY entrypoint.sh /run/

# TODO: replace custom repository when yarn is no longer in edge/community
RUN apk add yarn --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ && \
    chmod 777 /app/ai-chat-app && \
    mv /app/ai-chat-app/.env.example /app/ai-chat-app/.env && \
    chmod 777 /run && \
    chmod +x /run/entrypoint.sh && \
    cd /app/ai-chat-app && \
    yarn install && \
    yarn prisma migrate deploy && \
    yarn build

EXPOSE 3000

ENTRYPOINT ["/run/entrypoint.sh"]