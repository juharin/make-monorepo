#!/bin/bash
set -e

# Create coverage directory if it doesn't exist
mkdir -p coverage-report

# Run tests with coverage
go test -coverprofile=coverage-report/coverage.out ./...

# Convert coverage profile to HTML
go tool cover -html=coverage-report/coverage.out -o coverage-report/coverage.html

echo "Coverage report generated at coverage-report/coverage.html" 