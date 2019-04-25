#!/bin/bash

dir=`pwd`

# set up the build directory
mkdir -p build
cd build

mkdir -p wasm
cd wasm

mkdir -p root
mkdir -p libvpx
cd libvpx

#

# finally, run configuration script
export EMCC_WASM_BACKEND=1
EMCONFIGURE_JS=1 STRIP="$dir/buildscripts/strip.sh" \
  emconfigure ../../../libvpx/configure \
    --prefix="$dir/build/wasm/root" \
    --target=generic-gnu \
    --extra-cflags=-s\ WASM=1\ -DWASM\ -s\ WASM_OBJECT_FILES=0\ -I`dirname \`which emcc\``/system/lib/libcxxabi/include/ \
    --disable-multithread \
    --enable-vp9-decoder \
    --disable-vp8-encoder \
    --disable-vp9-encoder \
    --disable-shared \
    --disable-docs \
    --disable-examples \
    --disable-tools \
|| exit 1

# compile libvpx
emmake make -j4 || exit 1
emmake make install || exit 1

cd ..
cd ..
cd ..