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

# protobuf
build_protobuf(){
  # see: https://github.com/protocolbuffers/protobuf/tree/main/src
  echo "build_protobuf"

  if [[ `uname -a` =~ "Darwin" ]]; then
    echo "PS: 只需要安装一次，后续可以注释，加快编译protobuf速度！"
    brew install autoconf automake libtool
  else
    echo "not support os!"
    exit 0
  fi

  cd $CUR_DIR/protobuf-3.19.4
  # 编译静态库、protoc执行文件
  # --disable-shared: 编译静态库
  ./autogen.sh
  ./configure --prefix=$LIB_DIR --with-protoc=protoc --disable-shared
  make -j && make install
  make clean
}

# sqlite3的CPP封装（包含sqlite3源码），支持C++11
build_sqlitecpp(){
  echo "build_sqlitecpp"

  # exit on first error
  set -e

  cd $CUR_DIR/SQLiteCpp-3.1.1 && mkdir -p build && cd build

  # Generate a Makefile for GCC (or Clang, depanding on CC/CXX envvar)
  cmake -DCMAKE_BUILD_TYPE=Debug -DSQLITECPP_USE_ASAN=OFF -DSQLITECPP_USE_GCOV=OFF -DSQLITECPP_BUILD_EXAMPLES=OFF -DSQLITECPP_BUILD_TESTS=OFF ..

  # Build (ie 'make')
  cmake --build .

  # And with Valgrind
  #valgrind --leak-check=full --error-exitcode=1 ./SQLiteCpp_example1
  #valgrind --leak-check=full --error-exitcode=1 ./SQLiteCpp_tests

  cp libSQLiteCpp.a $LIB_DIR
  cp sqlite3/libsqlite3.a $LIB_DIR
  cd .. && rm -rf build
}

build_spdlog
build_libuv
build_protobuf
build_sqlitecpp