#!/usr/bin/env bash

set -ex

CRYSTAL_VERSION=$(cat ./CRYSTAL_VERSION)
EXPAND_VERSION=${CRYSTAL_VERSION}.$(cat ./EXPAND_VERSION)
LLVM_VERSION=3.5.0-1
LLVM_ARCH=linux-x86_64

if [[ -x ../../bin/expand ]] && [[ "$(../../bin/expand --version || echo oops)" = "$EXPAND_VERSION" ]]; then
  echo "expand is up-to-date: nothing to do"
  exit 0
fi

export CRYSTAL_CONFIG_VERSION=$CRYSTAL_VERSION
export CRYSTAL_CONFIG_PATH=/opt/crystal/src:./libs
export LIBRARY_PATH=/opt/crystal/embedded/lib

mkdir -p .deps
[[ -d ./.deps/crystal ]] || git clone \
  --depth=1 \
  https://github.com/crystal-lang/crystal \
  -b $CRYSTAL_VERSION \
  .deps/crystal

[[ -d "./.deps/llvm-${LLVM_VERSION}" ]] || curl http://crystal-lang.s3.amazonaws.com/llvm/llvm-${LLVM_VERSION}-${LLVM_ARCH}.tar.gz | tar xz -C ./.deps

export PATH=./.deps/llvm-${LLVM_VERSION}/bin:$PATH

(cd .deps/crystal && make LLVM_CONFIG=../llvm-${LLVM_VERSION}/bin/llvm-config deps)

crystal build ./expand.cr
mkdir -p ../../bin
cp ./expand ../../bin/
