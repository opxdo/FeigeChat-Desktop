cmake_minimum_required(VERSION 3.14)

project(chatkit)

#工程中使用vcpkg安装的库，改成自己的vcpkg安装目录
#如果是Qt Creator中使用，请参考这篇文章：https://blog.csdn.net/xmcy001122/article/details/124900259
#set(CMAKE_TOOLCHAIN_FILE "/Users/xuyc/repo/github/vcpkg/scripts/buildsystems/vcpkg.cmake")

# 库名字和版本号设置
set(ChatKitLib chatkit)
set(ChatKitLib_VERSION 0.1.0)

# 源码文件
aux_source_directory(cim CHAT_KIT_SRC)
aux_source_directory(cim/base CHAT_KIT_SRC)
aux_source_directory(cim/base/file CHAT_KIT_SRC)
aux_source_directory(cim/base/util CHAT_KIT_SRC)
aux_source_directory(cim/core CHAT_KIT_SRC)
aux_source_directory(cim/crypt CHAT_KIT_SRC)
aux_source_directory(cim/db CHAT_KIT_SRC)
aux_source_directory(cim/pb CHAT_KIT_SRC)

if (APPLE) # 使用vcpkg 快速安装的依赖
    find_package(Protobuf CONFIG REQUIRED)
    find_package(spdlog CONFIG REQUIRED)
    find_package(restclient-cpp CONFIG REQUIRED)
    find_package(SQLiteCpp CONFIG REQUIRED)
    find_package(unofficial-libuv CONFIG REQUIRED)
#    find_package(evpp CONFIG REQUIRED)
    find_package(nlohmann_json CONFIG REQUIRED)
endif ()

# 动态库
add_library(${ChatKitLib} SHARED ${CHAT_KIT_SRC})
#add_library(${ChatKitLib} STATIC)
# 起一个别名
add_library(cim::chatkit ALIAS ${PROJECT_NAME})

target_include_directories(${PROJECT_NAME}
        PUBLIC
        ${PROJECT_SOURCE_DIR} # chatKit目录，这样外部就能找到头文件所在目录了
        ${THIRD_LIB_DIR}    # 第三方库
        )
target_link_directories(${PROJECT_NAME}
        PUBLIC
        ${THIRD_INCLUDE_DIR} # 第三方库的头文件
        )

target_link_libraries(${ChatKitLib}
        PRIVATE
        # vcpkg引入依赖在macOS下，是静态库，windiws下，需要显式安装静态库，否则为动态库
#        protobuf::libprotobuf-lite
#        restclient-cpp
#        SQLiteCpp
#        spdlog::spdlog_header_only
#        nlohmann_json::nlohmann_json
#        unofficial::libuv::libuv
#        )

        # 自己编译引入
        protobuf::libprotobuf-lite
        restclient-cpp
        SQLiteCpp
        spdlog.a
        nlohmann_json::nlohmann_json
        unofficial::libuv::libuv
        )

# 静态库
#        libprotobuf-lite.a
#        spdlog.a
#        evpp libfmt.a libssl.a libcrypto.a
#        SQLiteCpp.a libsqlite3.a
#        librestclient-cpp.a libcurl.a)
#        )