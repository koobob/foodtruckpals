FROM elixir:1.15.6
RUN mix local.hex --force
WORKDIR /usr/src/app
