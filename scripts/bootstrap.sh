#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting monorepo bootstrap...${NC}"

# Verify required tools are installed
check_command() {
  if ! command -v $1 &> /dev/null; then
    echo "Error: $1 is required but not installed. Please install it and try again."
    exit 1
  fi
}

echo "Checking required tools..."
check_command git
check_command make
check_command node
check_command npm
check_command go
check_command flutter

# Create necessary directories
mkdir -p bin

# Setup Git hooks
echo "Setting up Git hooks..."
mkdir -p .git/hooks
cp tools/git-hooks/* .git/hooks/ 2>/dev/null || true
chmod +x .git/hooks/*

# Install dependencies
echo "Installing dependencies for all projects..."
make deps

# Setup complete
echo -e "${GREEN}Bootstrap complete! Your monorepo is ready.${NC}"
echo "Run 'make help' to see available commands."
