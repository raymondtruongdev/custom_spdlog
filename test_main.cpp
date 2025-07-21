#include "logger.hpp"

int main() {
    auto logger = create_logger("test_app");
    logger->info("Hello from installed custom_spdlog package!");
    logger->warn("This is a warning message");
    logger->error("This is an error message");
    
    return 0;
}