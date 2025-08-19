# F-Droid Metadata Files

## Overview
This document describes the F-Droid metadata files created for the TV Assassin application.

## File Structure
```
tv_assassin/
├── fastlane/
│   └── metadata/
│       └── android/
│           ├── full_description.txt
│           ├── short_description.txt
│           ├── promo_text.txt
│           └── default_locale.txt
└── metadata/
    └── en-US/
        ├── full_description.txt
        ├── short_description.txt
        └── version.txt
```

## File Descriptions

### fastlane/metadata/android/full_description.txt
Contains the full description of the application for the Google Play Store and other app stores.

### fastlane/metadata/android/short_description.txt
Contains a short description of the application (80 characters or less).

### fastlane/metadata/android/promo_text.txt
Contains promotional text for the application.

### fastlane/metadata/android/default_locale.txt
Specifies the default locale for the metadata.

### metadata/en-US/full_description.txt
Contains the full description of the application specifically for F-Droid, including categories, license, author information, and permissions.

### metadata/en-US/short_description.txt
Contains a short description of the application for F-Droid.

### metadata/en-US/version.txt
Contains the current version number of the application for F-Droid.

## F-Droid Compliance
These metadata files are structured to be compatible with F-Droid's requirements:
- Proper directory structure
- Required metadata fields
- Text-based format for easy parsing
- Version tracking
- Descriptive content for users

## Maintenance
When updating the application:
1. Update version.txt with the new version number
2. Update descriptions if features change
3. Ensure all metadata remains accurate and compliant