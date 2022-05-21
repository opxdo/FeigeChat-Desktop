#!/bin/sh

CUR_DIR=`PWD`
LIB_DIR=`PWD`/lib

# google 跨平台log组件
build_spdlog(){
  echo "build_spdlog"
  cd $CUR_DIR/spdlog-1.9.2 && mkdir build && cd build
  cmake .. && make -j
  cp libspdlog* $LIB_DIR
  cd .. && rm -rf build
}

# c跨平台网络库
build_libuv(){
  echo "build_libuv"
  cd $CUR_DIR/libuv-1.44.1 && mkdir build && cd build
  cmake .. && make
  cp libuv* $LIB_DIR
  cd .. && rm -rf build
}

#build_spdlog
build_libuv