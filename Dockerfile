FROM elixir:1.12-alpine

RUN apk update && \
    apk add git bash openssl inotify-tools alpine-sdk && \
    apk add nodejs npm python3 && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

# https://github.com/nodejs/node-gyp/issues/2451
# https://github.com/nodejs/node-gyp/blob/master/docs/Updating-npm-bundled-node-gyp.md
RUN npm install --global node-gyp@latest

WORKDIR /app
COPY . /app

ENV MIX_ENV=dev PORT=4000 APPSIGNAL_BUILD_FOR_MUSL=1
EXPOSE 4000
CMD ["sh", "-c", "cd assets && npm install; cd /app && mix do deps.get, phx.server"]
