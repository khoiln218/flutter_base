import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val versionProperties = Properties()
val versionPropertiesFile = rootProject.file("version.properties")
if (versionPropertiesFile.exists()) {
    FileInputStream(versionPropertiesFile).use { input ->
        versionProperties.load(input)
    }
}

android {
    namespace = "com.inetkr.base"
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
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.inetkr.base"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    flavorDimensions += "version"

    productFlavors {
        create("dev") {
            dimension = "version"
            versionCode = (versionProperties["versionCode.dev"] as String).toInt()
            versionName = versionProperties["versionName.dev"] as String
            applicationIdSuffix = ".dev"
            resValue("string", "appname", "Base DEV")
        }
        create("stg") {
            dimension = "version"
            versionCode = (versionProperties["versionCode.stg"] as String).toInt()
            versionName = versionProperties["versionName.stg"] as String
            applicationIdSuffix = ".stg"
            resValue("string", "appname", "Base STG")
        }
        create("prod") {
            dimension = "version"
            applicationIdSuffix = ".app"
            versionCode = (versionProperties["versionCode"] as String).toInt()
            versionName = versionProperties["versionName"] as String
            resValue("string", "appname", "Base")
        }
    }
}

flutter {
    source = "../.."
}
