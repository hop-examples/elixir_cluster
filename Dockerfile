FROM elixir:1.13.4-alpine AS builder

WORKDIR /app

RUN apk update && apk add git

COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

COPY lib/ ./lib/

ENV MIX_ENV=prod
RUN mix release

FROM elixir:1.13.4-alpine

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/prod/ ./_build/prod/rel/prod/

ENV MIX_ENV=prod
ENV RELX_REPLACE_OS_VARS=true
ENV RELEASE_DISTRIBUTION=none
CMD ["_build/prod/rel/prod/bin/prod", "start"]
