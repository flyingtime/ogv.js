#!/bin/bash

# configure libvorbis
dir=`pwd`
cd tremor
if [ ! -f configure ]; then
  # generate configuration script
  # disable running configure automatically
  sed -i.bak 's/$srcdir\/configure/#/' autogen.sh
  ./autogen.sh
  
  # -O20 and -04 cause problems
  # see https://github.com/kripken/emscripten/issues/264
  sed -i.bak 's/-O20/-O2/g' configure
  sed -i.bak 's/-O4/-O2/g' configure
  
  # disable oggpack_writealign test
  sed -i.bak 's/$ac_cv_func_oggpack_writealign/yes/' configure
fi
cd ..

# set up the build directory
mkdir build
cd build

mkdir root
mkdir tremor
cd tremor
  

# finally, run configuration script
emconfigure ../../tremor/configure --enable-low-accuracy --disable-oggtest --disable-shared --prefix="$dir/build/root"

# compile tremor
emmake make
emmake make install

cd ..
cd ..