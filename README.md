# FeigeChat-Desktop
（飞鸽🐦Chat）open source im desktop client with Qt Quick, test in macOS &amp; Windows

# Build in macOS

## Require

cmake: 3.14+
qt: > 6.2.3
clang: 12.0.5+
xcode: 12.5.1+

## Vcpkg

## Depends

自己编译（src/3rd-party）：
- spdlog: 1.9.2

使用vcpkg：
```bash
$ vcpkg install spdlog           # c++log库, see: https://github.com/gabime/spdlog
$ vcpkg install protobuf         # 3.14.0（如果版本变了，请重新生成protobuf文件）, see: https://github.com/protocolbuffers/protobuf
$ vcpkg install restclient-cpp   # c++ wraps libcurl for HTTP requests, see: https://github.com/mrtazz/restclient-cpp
# $ vcpkg install toml11         # toml解析库，header only, see: https://github.com/ToruNiina/toml11
# $ vcpkg install crossguid      # 跨平台guid，see: https://github.com/graeme-hill/crossguid
$ vcpkg install nlohmann-json    # json解析库，比jsoncpp好用，see: https://github.com/nlohmann/json
$ vcpkg install sqlitecpp        # sqlite3的封装库，see: https://github.com/SRombauts/SQLiteCpp
$ vcpkg install gtest            # google unit test, see: https://github.com/google/googletest
```

> ps：在macOS上，vcpkg install protobuf安装的是静态库，在windows上，安装的是动态库，静态库需要替换为：vcpkg install protobuf:x86-windows-static

## Build

```bash
$ cd mac
$ cmake -S . -B build
$ cd build && make
```

## Build with Xcode

```bash
$ cd mac
$ cmake -G "Xcode" -DPROJECT_ARCH="x86_64" -S . -B build
```

open build / xocde.workspace, then select HelloChat target and run.

## Build with Clion

add cmake options(Preferences>Build,Execution>CMake>CMake options): 
```bash
-DCMAKE_TOOLCHAIN_FILE=[vcpkg root]/scripts/buildsystems/vcpkg.cmake
# -DCMAKE_TOOLCHAIN_FILE=/Users/xuyc/repo/github/vcpkg/scripts/buildsystems/vcpkg.cmake
```

macOS：Clion建议设置Clang编译器
- toolchains
    - Build Tools: /usr/bin/make
    - C Compiler: /usr/bin/clang
    - C++ Compiler: /usr/bin/clang++

# Build with Qt Creator

具体见：[qt creator使用vcpkg](https://blog.csdn.net/xmcy001122/article/details/124900259)
