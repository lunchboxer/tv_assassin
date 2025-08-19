# Version Numbering Scheme

## Overview
The TV Assassin application follows Semantic Versioning (SemVer) principles for version numbering.

## Format
The version number follows the format: `MAJOR.MINOR.PATCH+BUILD`

Example: `1.0.0+1`

### Components
1. **MAJOR**: Incremented for incompatible API changes or major feature releases
2. **MINOR**: Incremented for backward-compatible functionality additions
3. **PATCH**: Incremented for backward-compatible bug fixes
4. **BUILD**: Incremented for each build, used for internal tracking

## Versioning Rules
- MAJOR version resets MINOR and PATCH to 0 when incremented
- MINOR version resets PATCH to 0 when incremented
- PATCH version increments independently for bug fixes
- BUILD number increments with each release build

## Release Process
1. Update version in `pubspec.yaml`
2. Create Git tag with the same version number
3. Build and release APK

## Example Version Progression
- 1.0.0+1 (Initial release)
- 1.0.1+2 (Bug fix release)
- 1.1.0+3 (New feature release)
- 2.0.0+4 (Major breaking change)

## F-Droid Compliance
This versioning scheme is compliant with F-Droid requirements:
- Clear version numbering
- Build numbers for tracking
- Semantic versioning for feature tracking