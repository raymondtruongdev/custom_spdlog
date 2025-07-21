# Example CMakeLists.txt showing how to use the installed custom_spdlog package

cmake_minimum_required(VERSION 3.31)
project(TestCustomSpdlog)

set(CMAKE_CXX_STANDARD 20)

# Find the custom_spdlog package
find_package(custom_spdlog REQUIRED)

# Create a test executable
add_executable(test_app test_main.cpp)

# Link with the custom_spdlog library
target_link_libraries(test_app PRIVATE custom_spdlog::custom_spdlog)

# Print some information about the found package
message(STATUS "Found custom_spdlog version: ${custom_spdlog_VERSION}")
message(STATUS "Custom spdlog targets available:")
get_target_property(INCLUDE_DIRS custom_spdlog::custom_spdlog INTERFACE_INCLUDE_DIRECTORIES)
message(STATUS "  Include directories: ${INCLUDE_DIRS}")