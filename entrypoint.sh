#!/bin/bash
set -e

# Base command
CMD="rsmetacheck"

# Handle required input
if [ -n "$INPUT_INPUT" ]; then
  # Note: Do not quote $INPUT_INPUT here in case multiple URLs are passed as spaces
  CMD="$CMD --input $INPUT_INPUT"
else
  echo "Error: The 'input' argument is required."
  exit 1
fi

# Handle boolean flags
if [ "$INPUT_SKIP_SOMEF" = "true" ]; then
  CMD="$CMD --skip-somef"
fi

if [ "$INPUT_GENERATE_CODEMETA" = "true" ]; then
  CMD="$CMD --generate-codemeta"
fi

if [ "$INPUT_VERBOSE" = "true" ]; then
  CMD="$CMD --verbose"
fi

# Handle parameters with values
if [ -n "$INPUT_PITFALLS_OUTPUT" ]; then
  CMD="$CMD --pitfalls-output \"$INPUT_PITFALLS_OUTPUT\""
fi

if [ -n "$INPUT_SOMEF_OUTPUT" ]; then
  CMD="$CMD --somef-output \"$INPUT_SOMEF_OUTPUT\""
fi

if [ -n "$INPUT_ANALYSIS_OUTPUT" ]; then
  CMD="$CMD --analysis-output \"$INPUT_ANALYSIS_OUTPUT\""
fi

if [ -n "$INPUT_THRESHOLD" ]; then
  CMD="$CMD --threshold \"$INPUT_THRESHOLD\""
fi

if [ -n "$INPUT_BRANCH" ]; then
  CMD="$CMD --branch \"$INPUT_BRANCH\""
fi

echo "Executing RsMetaCheck command:"
echo "$CMD"

# Evaluate the command so spaces inside quotes are respected properly
eval "$CMD"
