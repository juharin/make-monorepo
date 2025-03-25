!/bin/bash
set -e

# This script generates model code from a common schema for all platforms

SCHEMA_DIR="packages/models/schema"
TS_OUTPUT_DIR="packages/models/typescript/src"
GO_OUTPUT_DIR="packages/models/go"
DART_OUTPUT_DIR="packages/models/dart/lib/src"

echo "Generating models from schema..."

# Create output directories if they don't exist
mkdir -p $TS_OUTPUT_DIR
mkdir -p $GO_OUTPUT_DIR
mkdir -p $DART_OUTPUT_DIR

# Process each schema file
for schema_file in $SCHEMA_DIR/*.json; do
  filename=$(basename -- "$schema_file")
  model_name="${filename%.*}"
  
  echo "Processing model: $model_name"
  
  # Example generation commands (replace with actual tools)
  # TypeScript
  echo "Generating TypeScript model..."
  # json-schema-to-typescript $schema_file > $TS_OUTPUT_DIR/$model_name.ts
  
  # Go
  echo "Generating Go model..."
  # gojsonschema $schema_file > $GO_OUTPUT_DIR/$model_name.go
  
  # Dart/Flutter
  echo "Generating Dart model..."
  # json_schema_dart $schema_file > $DART_OUTPUT_DIR/$model_name.dart
done

echo "Model generation complete!"
