# Custom spdlog Library

A custom logging library wrapper around [spdlog](https://github.com/gabime/spdlog) with colorized output and clickable file links.

## Features

- Colorized log output with different colors for each log level
- Clickable file:line links in IDEs (like CLion)
- Easy integration with CMake projects
- C++20 compatible

## Usage

### As a Git Submodule

1. Add this repository as a submodule to your project:
```bash
git submodule add https://github.com/raymondtruongdev/custom_spdlog.git deps/custom_spdlog
git submodule update --init --recursive
```

2. In your CMakeLists.txt:
```cmake
cmake_minimum_required(VERSION 3.31)
project(my_project)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set variable PROJECT_ROOT as the root directory of the project, we can use it in our source files
add_compile_definitions(PROJECT_ROOT="${CMAKE_SOURCE_DIR}")

# Add custom_spdlog as subdirectory
add_subdirectory(deps/custom_spdlog)

# Set the log level of 'spdlog' globally to control which log messages are displayed
add_compile_definitions(SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_INFO)

# Your executable or library
add_executable(your_target main.cpp)
target_link_libraries(your_target PRIVATE custom_spdlog::custom_spdlog)
```

### Using FetchContent

```cmake
cmake_minimum_required(VERSION 3.31)
project(my_project)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set variable PROJECT_ROOT as the root directory of the project, we can use it in our source files
add_compile_definitions(PROJECT_ROOT="${CMAKE_SOURCE_DIR}")

#Using FetchContent (download automatically) the custom_spdlog library
include(FetchContent)
FetchContent_Declare(
    custom_spdlog
    GIT_REPOSITORY https://github.com/your-username/custom_spdlog.git
    GIT_TAG main  # or a specific tag/commit
)
FetchContent_MakeAvailable(custom_spdlog)

# Set the log level of 'spdlog' globally to control which log messages are displayed
add_compile_definitions(SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_INFO)


# Your executable or library
add_executable(your_target main.cpp)
target_link_libraries(your_target PRIVATE custom_spdlog::custom_spdlog)
```

### In Your Code

```cpp
#include "logger.hpp"

int main() {
    Logger::setLevel("warn");
    // Optional: set local level here must less than or equal to the level (SPDLOG_ACTIVE_LEVEL) in
    //  'CMakeLists.txt' of root directory
    
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
- 
## SET LOG LEVEL FOR SHOWING:
### Global Log Level
You can set the log level globally in your `CMakeLists.txt` file. This will control which log messages are displayed based on the level you set.

 Can set the log level here:
 + `SPDLOG_LEVEL_TRACE`
 + `SPDLOG_LEVEL_DEBUG`
 + `SPDLOG_LEVEL_INFO`
 + `SPDLOG_LEVEL_WARN`
 + `SPDLOG_LEVEL_ERROR`
 + `SPDLOG_LEVEL_CRITICAL`
 + `SPDLOG_LEVEL_OFF`

```cmake
# Example: Set log level to WARN : means only WARN, ERROR, and CRITICAL messages will be shown
add_compile_definitions(SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_WARN)
```
### Local Log Level
You can also set the log level locally in your code. This allows you to control the log level for specific parts of your application.

```cpp
int main() {
    // Optional: set local level here must less than or equal to the level (SPDLOG_ACTIVE_LEVEL) in
    //  'CMakeLists.txt' of root directory
    Logger::setLevel("warn");
   
    LOG_TRACE("Demo log a TRACE message");
    LOG_DEBUG("Demo log a DEBUG message");
    LOG_INFO("Demo log a INFO message {}", 8080);
    LOG_WARN("Demo log a WARN message");
    LOG_ERROR("Demo log a ERROR message : {}", "error message");
    return 0;
}
```
## Config for a path file where print log messages
```cmake
# Example: Set log level to WARN : means only WARN, ERROR, and CRITICAL messages will be shown
# Set to 1 for full path of file in logging, 0 for relative paths
add_compile_definitions(USE_ABSOLUTE_PATHS_IN_LOGS=0)
```



# Modification this library
1. Run 'init_project.sh' to initialize the project and download dependencies.
2. Modify code in `logger.hpp` as needed.
3. Change option(`BUILD_EXAMPLES "Build example programs" ON`) in the `CMakeLists.txt` to build example for testing/debugging purposes.
4. Commit your changes and push to repository ( Remember set: `Change option(BUILD_EXAMPLES "Build example programs" OFF` in the `CMakeLists.txt` to do not build example programs in release).


