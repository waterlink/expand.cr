#!/usr/bin/env bash

CRYSTAL_VERSION=0.13.0

mkdir -p .deps
git clone \
  --depth=1 \
  https://github.com/crystal-lang/crystal \
  -b $CRYSTAL_VERSION \
  .deps/crystal
