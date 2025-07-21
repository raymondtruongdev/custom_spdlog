#!/bin/bash

set -e  # Exit if any command fails

# Configure spdlog version to use
SPDLOG_VERSION=${SPDLOG_VERSION:-v1.15.3}

echo "⚙️  Setting up spdlog submodule..."

# Check if submodule already exists and remove it for fresh pull
if [ -d "deps/spdlog" ]; then
  echo "🗑️  Removing existing spdlog directory..."
  
  # Try git submodule cleanup, but ignore errors if not a submodule
  git submodule deinit -f deps/spdlog 2>/dev/null || true
  git rm -f deps/spdlog 2>/dev/null || true
  
  # Always clean up the filesystem and git metadata
  rm -rf .git/modules/deps/spdlog
  rm -rf ./deps/spdlog
fi

echo "🔗 Adding spdlog as fresh submodule..."
git submodule add https://github.com/gabime/spdlog deps/spdlog

echo "🔄 Initializing and updating submodules..."
git submodule update --init --recursive

echo "📌 Checking out specific spdlog version: $SPDLOG_VERSION"
cd deps/spdlog
# Create and switch to a local branch for the specific version
git checkout -b local-$SPDLOG_VERSION tags/$SPDLOG_VERSION
cd ../..

echo "✅ Submodule setup complete!"