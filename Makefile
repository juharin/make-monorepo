# Main Makefile for monorepo orchestration

# Configuration
SHELL := /bin/bash
.PHONY: all clean setup build test dev deps lint format help

# Define path constants
WEB_APP_PATH := apps/web-app
API_SERVER_PATH := apps/api-server
MOBILE_APP_PATH := apps/mobile_app
MOBILE_HOST_APP_PATH := apps/mobile_host_app
SCRIPTS_PATH := scripts

# Default target
all: help

# Setup the repository
setup:
	@echo "Setting up the monorepo..."
	@$(SCRIPTS_PATH)/bootstrap.sh

# Install dependencies
deps: deps-web deps-api deps-mobile deps-mobile-host
	@echo "All dependencies installed"

deps-web:
	@echo "Installing web app dependencies..."
	@cd $(WEB_APP_PATH) && npm install

deps-api:
	@echo "Installing API server dependencies..."
	@cd $(API_SERVER_PATH) && go mod download

deps-mobile:
	@echo "Installing mobile app dependencies..."
	@cd $(MOBILE_APP_PATH) && flutter pub get

deps-mobile-host:
	@echo "Installing mobile host app dependencies..."
	@cd $(MOBILE_HOST_APP_PATH) && flutter pub get

# Build targets
build: build-web build-api build-mobile build-mobile-host
	@echo "All applications built successfully"

build-web:
	@echo "Building web app..."
	@cd $(WEB_APP_PATH) && npm run build
	@echo "Web app built successfully"

build-api:
	@echo "Building API server..."
	@cd $(API_SERVER_PATH) && go build -o ../../bin/api-server ./cmd/server
	@echo "API server built successfully"

build-mobile:
	@echo "Building mobile app..."
	@cd $(MOBILE_APP_PATH) && flutter build apk && flutter build ios
	@echo "Mobile app built successfully"

build-mobile-host:
	@echo "Building mobile host app..."
	@cd $(MOBILE_HOST_APP_PATH) && flutter build apk && flutter build ios
	@echo "Mobile host app built successfully"

build-mobile-web:
	@echo "Building mobile app for web..."
	@cd $(MOBILE_APP_PATH) && flutter build web --wasm
	@cp -r $(MOBILE_APP_PATH)/build/web/* $(WEB_APP_PATH)/public
	@echo "Mobile app for web built successfully"

# Test targets
test: test-web test-api test-mobile test-mobile-host
	@echo "All tests passed"

test-web:
	@echo "Testing web app..."
	@cd $(WEB_APP_PATH) && npm test -- run

test-api:
	@echo "Testing API server..."
	@cd $(API_SERVER_PATH) && go test ./...

test-mobile:
	@echo "Testing mobile app..."
	@cd $(MOBILE_APP_PATH) && flutter test

test-mobile-host:
	@echo "Testing mobile host app..."
	@cd $(MOBILE_HOST_APP_PATH) && flutter test

# Development servers
dev-web:
	@echo "Starting web development server..."
	@cd $(WEB_APP_PATH) && npm run dev

dev-api:
	@echo "Starting API development server..."
	@cd $(API_SERVER_PATH) && go run ./cmd/server

dev-mobile:
	@echo "Starting Flutter development..."
	@cd $(MOBILE_APP_PATH) && flutter run

dev-mobile-host:
	@echo "Starting Flutter development for mobile host..."
	@cd $(MOBILE_HOST_APP_PATH) && flutter run

dev-mobile-web:
	@echo "Starting Flutter development for web..."
	@cd $(MOBILE_APP_PATH) && flutter run -d chrome --wasm

# Linting
lint: lint-web lint-api lint-mobile lint-mobile-host
	@echo "All lint checks passed"

lint-web:
	@echo "Linting web app..."
	@cd $(WEB_APP_PATH) && npm run lint

lint-api:
	@echo "Linting API server..."
	@cd $(API_SERVER_PATH) && golangci-lint run

lint-mobile:
	@echo "Linting mobile app..."
	@cd $(MOBILE_APP_PATH) && flutter analyze

lint-mobile-host:
	@echo "Linting mobile host app..."
	@cd $(MOBILE_HOST_APP_PATH) && flutter analyze

# Formatting
format: format-web format-api format-mobile format-mobile-host
	@echo "All code formatted"

format-web:
	@echo "Formatting web app code..."
	@cd $(WEB_APP_PATH) && npm run format

format-api:
	@echo "Formatting Go code..."
	@cd $(API_SERVER_PATH) && go fmt ./...

format-mobile:
	@echo "Formatting Flutter code..."
	@cd $(MOBILE_APP_PATH) && flutter format .

format-mobile-host:
	@echo "Formatting Flutter host app code..."
	@cd $(MOBILE_HOST_APP_PATH) && flutter format .

# Generate shared models across platforms
generate-models:
	@echo "Generating models..."
	@$(SCRIPTS_PATH)/generate-models.sh

# Clean build artifacts
clean: clean-web clean-api clean-mobile
	@echo "All build artifacts cleaned"
	@rm -rf bin/*

clean-web:
	@echo "Cleaning web app build artifacts..."
	@cd $(WEB_APP_PATH) && rm -rf dist node_modules

clean-api:
	@echo "Cleaning API server build artifacts..."
	@cd $(API_SERVER_PATH) && go clean

clean-mobile:
	@echo "Cleaning mobile app build artifacts..."
	@cd $(MOBILE_APP_PATH) && flutter clean

clean-mobile-host:
	@echo "Cleaning mobile host app build artifacts..."
	@cd $(MOBILE_HOST_APP_PATH) && flutter clean

# Help
help:
	@echo "Monorepo Management Commands:"
	@echo "  setup          - Setup the repository"
	@echo "  deps           - Install all dependencies"
	@echo "  build          - Build all applications"
	@echo "  test           - Run all tests"
	@echo "  dev-web        - Start web development server"
	@echo "  dev-api        - Start API development server"
	@echo "  dev-mobile     - Start Flutter development"
	@echo "  dev-mobile-host - Start Flutter development for mobile host"
	@echo "  dev-mobile-web - Start Flutter development for web"
	@echo "  lint           - Run all linters"
	@echo "  format         - Format all code"
	@echo "  clean          - Clean all build artifacts"
	@echo "  generate-models - Generate shared models across platforms"
