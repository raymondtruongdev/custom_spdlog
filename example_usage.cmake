# Example CMakeLists.txt for projects that want to use custom_spdlog library

cmake_minimum_required(VERSION 3.31)
project(my_project)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Option 1: Using as Git Submodule
# git submodule add https://github.com/raymondtruongdev/custom_spdlog.git deps/custom_spdlog
# git submodule update --init --recursive
add_subdirectory(deps/custom_spdlog)

# Option 2: Using FetchContent (download automatically)
# include(FetchContent)
# FetchContent_Declare(
#     custom_spdlog
#     GIT_REPOSITORY https://github.com/raymondtruongdev/custom_spdlog.git
#     GIT_TAG master  # or specific version tag
# )
# FetchContent_MakeAvailable(custom_spdlog)

# Your application/library
add_executable(my_app main.cpp)

# Link with custom_spdlog
target_link_libraries(my_app PRIVATE custom_spdlog::custom_spdlog)

# If you're creating a library that uses custom_spdlog:
# add_library(my_library src/my_lib.cpp)
# target_include_directories(my_library PUBLIC include)
# target_link_libraries(my_library PUBLIC custom_spdlog::custom_spdlog)