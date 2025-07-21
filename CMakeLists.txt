cmake_minimum_required(VERSION 3.31)
project(custom_spdlog VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add spdlog as subdirectory
add_subdirectory(deps/spdlog)

# Set the log level of 'spdlog' globally to control which log messages are displayed
# + SPDLOG_LEVEL_TRACE
# + SPDLOG_LEVEL_DEBUG
# + SPDLOG_LEVEL_INFO
# + SPDLOG_LEVEL_WARN
# + SPDLOG_LEVEL_ERROR
# + SPDLOG_LEVEL_CRITICAL
# + SPDLOG_LEVEL_OFF
add_compile_definitions(SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_INFO)

# Create the main library (header-only)
add_library(custom_spdlog INTERFACE)

# Include directories
target_include_directories(custom_spdlog INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include>
)

# Link with spdlog - use the alias to ensure proper export
target_link_libraries(custom_spdlog INTERFACE spdlog::spdlog)

# Create an alias for consistent usage
add_library(custom_spdlog::custom_spdlog ALIAS custom_spdlog)

# Optional: Build example executable (can be disabled with -DBUILD_EXAMPLES=OFF)
option(BUILD_EXAMPLES "Build example programs" OFF)
if(BUILD_EXAMPLES)
    add_executable(custom_spdlog_example main.cpp)
    target_link_libraries(custom_spdlog_example PRIVATE custom_spdlog::custom_spdlog)
endif()

# Installation setup
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# Install the library target along with spdlog
install(TARGETS custom_spdlog spdlog
    EXPORT custom_spdlogTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Install header files
install(FILES logger.hpp
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Export targets
install(EXPORT custom_spdlogTargets
    FILE custom_spdlogTargets.cmake
    NAMESPACE custom_spdlog::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/custom_spdlog
)

# Configure package config file
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/custom_spdlogConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/custom_spdlogConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/custom_spdlog
)

# Generate package version file
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/custom_spdlogConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

# Install config files
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/custom_spdlogConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/custom_spdlogConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/custom_spdlog
)