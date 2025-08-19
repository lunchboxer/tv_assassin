import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "io.github.lunchboxer.tv_assassin"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "io.github.lunchboxer.tv_assassin"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 26  // Android 8.0 (API 26) as required
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    signingConfigs {
        create("release") {
            // Use environment variables in CI/CD, otherwise use key.properties file
            keyAlias = keystoreProperties["keyAlias"]?.toString() ?: System.getenv("KEY_ALIAS") ?: ""
            keyPassword = keystoreProperties["keyPassword"]?.toString() ?: System.getenv("KEY_PASSWORD") ?: ""
            storePassword = keystoreProperties["storePassword"]?.toString() ?: System.getenv("KEYSTORE_PASSWORD") ?: ""
            
            // For storeFile, in CI/CD we use the path to the decoded keystore
            val storeFilePath = keystoreProperties["storeFile"]?.toString() ?: "android/app/upload-keystore.jks"
            storeFile = file(storeFilePath)
        }
    }

    buildTypes {
        debug {
            // Debug build type for development
            isDebuggable = true
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-DEBUG"
        }
        
        release {
            signingConfig = signingConfigs.getByName("release")
            
            // Enable code shrinking and obfuscation
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                *fileTree(".") { include("**/*.pro") }.files.toTypedArray(),
                getDefaultProguardFile("proguard-android-optimize.txt"),
            )
        }
    }
}

flutter {
    source = "../.."
}
