project(chatKitUnitTest)

aux_source_directory(. SRC)

#find_package(Protobuf CONFIG REQUIRED)
find_package(GTest CONFIG REQUIRED)

add_executable(unit_test ${SRC})

target_link_libraries(unit_test cim::chatkit libprotobuf-lite.a GTest::gtest)