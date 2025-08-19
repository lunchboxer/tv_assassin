# Reproducible Build Verification Process

## Overview
This document describes the reproducible build verification process for the TV Assassin application, which is required for F-Droid inclusion.

## What are Reproducible Builds?
Reproducible builds are a process of compiling software which ensures that the resulting binary is bit-by-bit identical no matter when or where it is built. This allows third parties to verify that the distributed APK matches the source code.

## Current Status
The TV Assassin application is designed to support reproducible builds through:

1. **Deterministic Build Process**: Using Flutter's build system which produces consistent output
2. **Version Control**: All source code is managed in Git
3. **Dependency Locking**: Using `pubspec.lock` to ensure consistent dependencies
4. **Build Configuration**: Consistent build settings in `build.gradle.kts`

## Verification Process

### Prerequisites
- Flutter SDK 3.19 or compatible version
- Android SDK with build tools
- Same version of Java/Gradle used for original build

### Steps to Verify

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/tv-assassin.git
   cd tv-assassin/tv_assassin
   ```

2. **Checkout Specific Release**
   ```bash
   git checkout tags/v1.0.0  # Replace with actual tag
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Build APK**
   ```bash
   flutter build apk --release
   ```

5. **Compare with Distributed APK**
   Use diffoscope or similar tools to compare the built APK with the distributed one:
   ```bash
   diffoscope app-release.apk /path/to/distributed/app-release.apk
   ```

## F-Droid Requirements

### Build Metadata
F-Droid requires specific metadata in the `metadata` directory:
- `full_description.txt`: Detailed app description
- `short_description.txt`: Brief app description
- `version.txt`: Current version number

### Build Tools
F-Droid uses a standardized build environment:
- Specific versions of build tools
- Isolated build environment
- No network access during build

### Verification
F-Droid automatically verifies builds by:
1. Building from source
2. Comparing checksums with previous builds
3. Ensuring deterministic output

## Best Practices for Maintaining Reproducibility

1. **Lock Dependencies**: Always commit `pubspec.lock`
2. **Use Specific Versions**: Pin Flutter and package versions
3. **Avoid Timestamps**: Don't include build timestamps in the APK
4. **Consistent Environment**: Document exact build environment requirements
5. **Test Builds**: Regularly test the build process locally

## Known Issues
Currently, there are no known issues that would prevent reproducible builds. However, the following should be monitored:

1. Flutter version updates may affect build output
2. Android SDK updates may introduce non-deterministic elements
3. Third-party package updates should be carefully reviewed

## Future Improvements
1. Set up automated reproducible build verification in CI
2. Document exact build environment specifications
3. Create a verification script for easy comparison