# Dockerfile for running tests on different versions of lua.
# Usage:
# podman build -t lua-igt-dev .
# podman run lua-igt-dev
FROM ubuntu

RUN apt-get update
RUN apt-get -y install vim lua5.1 lua5.2 lua5.3 lua5.4 liblua5.1-dev liblua5.2-dev liblua5.3-dev liblua5.4-dev luarocks

WORKDIR home
COPY lua-igt-dev-1.rockspec .

# NOTE COPY only copies files, not directories.
# (Copy contents of scripts into scripts/)
COPY scripts scripts/

RUN luarocks --lua-version 5.1 init
RUN luarocks --lua-version 5.2 init
RUN luarocks --lua-version 5.3 init
RUN luarocks --lua-version 5.4 init

# `luarocks test --prepare` doesn't seem to work

COPY src src/

RUN luarocks --lua-version 5.1 make
RUN luarocks --lua-version 5.2 make
RUN luarocks --lua-version 5.3 make
RUN luarocks --lua-version 5.4 make

COPY spec spec/

CMD ["sh", "-c", "luarocks --lua-version 5.1 test && luarocks --lua-version 5.2 test && luarocks --lua-version 5.3 test && luarocks --lua-version 5.4 test"]
