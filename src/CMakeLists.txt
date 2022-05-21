cmake_minimum_required(VERSION 3.14)

project(mac)

add_definitions(
        -g
        -fPIC
        -D__STDC_FORMAT_MACROS
        -Wall
        -Wno-unused-parameter
        -Wno-unused-function
        -Wno-unused-const-variable
        -Wno-unused-variable
        -Wno-unused-value
        -Wshadow
        -Wcast-qual
        -Wcast-align
        -Wwrite-strings
        -Wsign-compare
        -Winvalid-pch
        -fms-extensions
        -Wfloat-equal
        -Wextra
        -std=c++14
        #-Werror # 警告视为错误，比较严格，可以根据需求启用
)

# hellochat 通过该标志判断是否在Qt Creator中打开
set(IN_CLION_IDE true CACHE INTERNAL "is in clion ide")
set(THIRD_LIB_DIR 3rd-party/lib)
set(THIRD_INCLUDE_DIR
        3rd-party/spdlog/include
        )

# 库
add_subdirectory(chatkit)
add_subdirectory(feigechat)

# 生成demo
set(BUILD_DEMO true)
if (BUILD_DEMO)
    add_subdirectory(test/client)
    add_subdirectory(test/unit_test)
endif ()