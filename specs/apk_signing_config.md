# APK Signing Configuration

## Overview
This document describes the APK signing configuration for the TV Assassin application.

## Current Configuration
The application is configured to use a keystore for signing release builds.

### Key Properties
The signing configuration is defined in `android/key.properties`:

```
keyAlias=upload
keyPassword=Peck-Outlook-Invade
storeFile=/home/james/upload-keystore.jks
storePassword=Peck-Outlook-Invade
```

### Build Configuration
The signing configuration is applied in `android/app/build.gradle.kts`:

```kotlin
buildTypes {
    release {
        signingConfig = signingConfigs.getByName("debug")
        // Enable code shrinking and obfuscation
        isMinifyEnabled = true
        isShrinkResources = true
        proguardFiles(
            *fileTree(".") { include("**/*.pro") }.files.toTypedArray(),
            getDefaultProguardFile("proguard-android-optimize.txt"),
        )
    }
}
```

## Security Considerations
1. The current configuration uses a debug signing config for release builds, which is not suitable for production
2. The keystore file path is hardcoded to a specific user's directory
3. Passwords are stored in plain text in the key.properties file

## Recommended Improvements
For production deployment:
1. Generate a new production keystore with strong passwords
2. Store the keystore in a secure location (e.g., encrypted storage)
3. Use environment variables or secure secret management for passwords
4. Update the build configuration to use the production keystore

## F-Droid Compliance
F-Droid will handle signing with its own keys, so the application-specific signing configuration is primarily for:
1. Developer testing
2. Direct APK distribution
3. Alternative app stores

The current configuration meets F-Droid's requirements for build reproducibility since it doesn't rely on external signing services.