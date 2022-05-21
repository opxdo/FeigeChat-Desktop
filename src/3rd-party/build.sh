#!/bin/sh

CUR_DIR=`PWD`
LIB_DIR=`PWD`/lib

build_spdlog(){
  echo "build_spdlog"
  cd $CUR_DIR/spdlog-1.9.2 && mkdir build && cd build
  cmake .. && make -j
  cp libspdlog* $LIB_DIR
  cd .. && rm -rf build
}

build_spdlog