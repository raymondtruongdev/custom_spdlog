# Custom spdlog Library

A C++20 header-only logging library wrapper around [spdlog](https://github.com/gabime/spdlog) with colorized output and clickable file links.

## Features

- Header-only library
- Colorized log output with different colors for each log level
- Clickable file:line links in IDEs (like CLion)
- Easy integration with CMake projects
- C++20 compatible

## Usage

### As a Git Submodule

1. Add this repository as a submodule to your project:
```bash
git submodule add https://github.com/your-username/custom_spdlog.git deps/custom_spdlog
git submodule update --init --recursive
```

2. In your CMakeLists.txt:
```cmake
cmake_minimum_required(VERSION 3.31)
project(my_project)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add custom_spdlog as subdirectory
add_subdirectory(deps/custom_spdlog)

# Your executable or library
add_executable(my_app main.cpp)
target_link_libraries(my_app PRIVATE custom_spdlog::custom_spdlog)
```

### Using FetchContent

```cmake
include(FetchContent)
FetchContent_Declare(
    custom_spdlog
    GIT_REPOSITORY https://github.com/your-username/custom_spdlog.git
    GIT_TAG main  # or a specific tag/commit
)
FetchContent_MakeAvailable(custom_spdlog)

target_link_libraries(your_target PRIVATE custom_spdlog::custom_spdlog)
```

### In Your Code

```cpp
#include "logger.hpp"

int main() {
    Logger::setLevel("trace");
    LOG_TRACE("Demo log a TRACE message");
    LOG_DEBUG("Demo log a DEBUG message");
    LOG_INFO("Demo log a INFO message {}", 8080);
    LOG_WARN("Demo log a WARN message");
    LOG_ERROR("Demo log a ERROR message : {}", "error message");
    return 0;
}
```

## Available Log Levels

- `LOG_TRACE(msg, ...)` - Gray color
- `LOG_DEBUG(msg, ...)` - Cyan color  
- `LOG_INFO(msg, ...)`  - Green color
- `LOG_WARN(msg, ...)`  - Yellow color
- `LOG_ERROR(msg, ...)` - Red color
- `LOG_CRITICAL(msg, ...)` - Pink color

## Building Examples

```bash
mkdir build && cd build
cmake ..
make
./custom_spdlog_example
```

To disable building examples:
```bash
cmake -DBUILD_EXAMPLES=OFF ..
```

## Installation

```bash
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make install
```

Then in other projects, you can find and use the library:
```cmake
find_package(custom_spdlog REQUIRED)
target_link_libraries(your_target PRIVATE custom_spdlog::custom_spdlog)
```

## Requirements

- C++20 compatible compiler
- CMake 3.31 or higher