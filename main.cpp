#include <iostream>
#include "logger.hpp"

int main() {
    // Optional: set local level here must less than or equal to the level (SPDLOG_ACTIVE_LEVEL) in
    // CMakeLists.txt of root directory
    Logger::setLevel("warn");

    LOG_TRACE("Demo log a TRACE message");
    LOG_DEBUG("Demo log a DEBUG message");
    LOG_INFO("Demo log a INFO message {}", 8080);
    LOG_WARN("Demo log a WARN message");
    LOG_ERROR("Demo log a ERROR message : {}", "error message");
    std::cout << "Application finished." << std::endl;
    return 0;
}
