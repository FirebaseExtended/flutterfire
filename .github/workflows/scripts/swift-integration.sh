#!/bin/bash

set -e

# Just Core example has pure Swift capability at the moment


# firebase_core iOS example

# Setup for SPM integration

echo "Building firebase core iOS example app with swift (SPM)"

cd packages/firebase_core/firebase_core/example/ios
rm Podfile
pod deintegrate

# Run the flutter build command and capture the output and exit status
flutter_output=$(flutter build ios --no-codesign)
flutter_exit_code=$?

# Check if the flutter build command was successful
if [[ $flutter_exit_code -ne 0 ]]; then
  echo "Flutter build failed with exit code $flutter_exit_code."
  exit 1
fi

# Check the output for the specific string
if [[ "$flutter_output" =~ "Running pod install" ]]; then
  echo "Failed. Pods are being installed when they should not be."
  exit 1
else
  echo "Successfully built iOS project using Swift Package Manager."
fi

# firebase_core macOS example

# Setup for SPM integration

echo "Building firebase core macOS example app with swift (SPM)"

cd ../macos
rm Podfile
pod deintegrate

# Run the flutter build command and capture the output and exit status
flutter_output=$(flutter build macos)
flutter_exit_code=$?

# Check if the flutter build command was successful
if [[ $flutter_exit_code -ne 0 ]]; then
  echo "Flutter build failed with exit code $flutter_exit_code."
  exit 1
fi

# Check the output for the specific string
if [[ "$flutter_output" =~ "Running pod install" ]]; then
  echo "Failed. Pods are being installed when they should not be."
  exit 1
else
  echo "Successfully built macOS project using Swift Package Manager."
  exit 0
fi
