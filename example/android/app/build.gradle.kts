plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    buildFeatures {
        buildConfig = true
    }

    namespace = "nz.co.electricbolt.appfigurateflutter_example"
    compileSdk = flutter.compileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "nz.co.electricbolt.appfigurateflutter_example"
        // 26 = Android 8.0 Marshmallow
        minSdk = 26
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        debug {
            buildConfigField("boolean", "ENCRYPTED", "false")
        }
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            buildConfigField("boolean", "ENCRYPTED", "true")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("nz.co.electricbolt:appfiguratelibrary:4.0.2")
}