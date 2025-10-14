# Build Instructions - LMS Mobile Flutter

## Prerequisites

### Required Software
- Flutter SDK 3.9.2 or higher
- Dart SDK 3.9.2 or higher
- Git

### Platform-Specific Requirements

#### Android
- Android Studio (latest stable)
- Android SDK 33 or higher
- Java JDK 11 or higher
- Android device or emulator (API 33+)

#### iOS
- macOS 12.0 or higher
- Xcode 15.0 or higher
- CocoaPods 1.11.0 or higher
- iOS device or simulator (iOS 13.0+)
- Apple Developer account (for physical device testing)

---

## Development Setup

### 1. Clone & Install Dependencies

```bash
git clone <repository-url>
cd lms_mobile_flutter

# Install Flutter dependencies
flutter pub get

# Verify Flutter setup
flutter doctor
```

### 2. Configure Android

#### Update AndroidManifest.xml

File: `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Add these permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    
    <!-- For WebRTC -->
    <uses-feature android:name="android.hardware.camera" android:required="false" />
    <uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
    <uses-feature android:name="android.hardware.microphone" android:required="false" />

    <application
        android:label="LMS Mobile"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <!-- ... -->
    </application>
</manifest>
```

#### Update build.gradle

File: `android/app/build.gradle`

```gradle
android {
    namespace = "com.example.lms_mobile_flutter"
    compileSdk = 34
    
    defaultConfig {
        applicationId = "com.example.lms_mobile_flutter"
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
        
        multiDexEnabled true
    }
    
    buildTypes {
        release {
            signingConfig = signingConfigs.debug
            minifyEnabled = true
            shrinkResources = true
        }
    }
}
```

### 3. Configure iOS

#### Update Info.plist

File: `ios/Runner/Info.plist`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Existing keys... -->
    
    <!-- Camera Permission -->
    <key>NSCameraUsageDescription</key>
    <string>We need camera access for video livestreaming and video calls with instructors</string>
    
    <!-- Microphone Permission -->
    <key>NSMicrophoneUsageDescription</key>
    <string>We need microphone access for audio in livestreaming and voice communication</string>
    
    <!-- Photo Library Permission -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>We need access to your photo library to upload images and files</string>
    
    <!-- File Access Permission -->
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>We need permission to save downloaded files to your photo library</string>
    
    <!-- Background Modes (for notifications) -->
    <key>UIBackgroundModes</key>
    <array>
        <string>remote-notification</string>
    </array>
</dict>
</plist>
```

#### Update Podfile

File: `ios/Podfile`

```ruby
# Uncomment this line to define a global platform for your project
platform :ios, '13.0'

# CocoaPods analytics sends network stats synchronously affecting flutter build latency.
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    # Fix for WebRTC and other pods
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
```

#### Install iOS Pods

```bash
cd ios
pod install
pod update
cd ..
```

---

## Running the App

### Development Mode

```bash
# Run on connected device/emulator (auto-detect)
flutter run

# Run on specific device
flutter devices  # List available devices
flutter run -d <device-id>

# Run on Android
flutter run -d android

# Run on iOS
flutter run -d ios

# Run with custom backend
flutter run --dart-define=API_BASE_URL=http://192.168.1.100:3000/api --dart-define=SOCKET_URL=http://192.168.1.100:3003
```

### Debug Mode

```bash
# Enable debug logging
flutter run --verbose

# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
# Quit: Press 'q' in terminal
```

---

## Building for Production

### Android APK

```bash
# Build debug APK
flutter build apk --debug

# Build release APK (single file)
flutter build apk --release

# Build release APK (split by ABI - smaller size)
flutter build apk --release --split-per-abi

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (AAB) - Google Play

```bash
# Build release AAB
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

#### Signing Android App

1. **Create keystore:**

```bash
keytool -genkey -v -keystore ~/lms-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias lms
```

2. **Create key.properties:**

File: `android/key.properties`

```properties
storePassword=<password>
keyPassword=<password>
keyAlias=lms
storeFile=/path/to/lms-release-key.jks
```

3. **Update build.gradle:**

File: `android/app/build.gradle`

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ...
    
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### iOS App

```bash
# Build debug iOS
flutter build ios --debug --no-codesign

# Build release iOS
flutter build ios --release

# Output: build/ios/iphoneos/Runner.app
```

#### Building for App Store

1. **Open Xcode:**

```bash
open ios/Runner.xcworkspace
```

2. **Configure signing:**
   - Select Runner project → Signing & Capabilities
   - Choose your Team
   - Update Bundle Identifier
   - Enable Automatic Signing

3. **Build archive:**
   - Product → Archive
   - Wait for build to complete
   - Organizer window opens

4. **Distribute:**
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Upload to TestFlight or submit for review

---

## Build Configurations

### Environment Variables

Create different configurations for dev/staging/production:

**Development:**
```bash
flutter run --dart-define=ENV=dev --dart-define=API_BASE_URL=http://localhost:3000/api
```

**Staging:**
```bash
flutter run --dart-define=ENV=staging --dart-define=API_BASE_URL=https://staging-api.example.com
```

**Production:**
```bash
flutter build apk --release --dart-define=ENV=production --dart-define=API_BASE_URL=https://api.example.com
```

### Build Flavors (Advanced)

For multiple app variants (dev/staging/prod):

**Android:** `android/app/build.gradle`
```gradle
android {
    flavorDimensions "environment"
    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
            versionNameSuffix "-staging"
        }
        prod {
            dimension "environment"
        }
    }
}
```

**Build commands:**
```bash
flutter build apk --flavor dev
flutter build apk --flavor staging
flutter build apk --flavor prod --release
```

---

## Testing Builds

### Install APK on Android

```bash
# Install via USB
adb install build/app/outputs/flutter-apk/app-release.apk

# Install via file transfer
# Copy APK to device → Open with File Manager → Install
```

### Install on iOS Device

```bash
# Via Xcode
open ios/Runner.xcworkspace
# Select device → Run

# Via TestFlight
# Upload to App Store Connect → TestFlight → Add testers
```

---

## Troubleshooting

### Android Issues

**1. Gradle build fails:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

**2. MultiDex error:**
- Add `multiDexEnabled true` in `android/app/build.gradle`

**3. Permission denied (gradlew):**
```bash
chmod +x android/gradlew
```

### iOS Issues

**1. Pod install fails:**
```bash
cd ios
pod deintegrate
pod install --repo-update
cd ..
```

**2. Code signing error:**
- Open Xcode → Runner → Signing & Capabilities
- Select valid Team
- Enable "Automatically manage signing"

**3. Simulator not found:**
```bash
open -a Simulator
flutter run -d ios
```

---

## Performance Optimization

### Reduce APK/IPA Size

```bash
# Android: Split by ABI
flutter build apk --release --split-per-abi

# iOS: Strip symbols
flutter build ios --release --obfuscate --split-debug-info=build/debug-symbols
```

### Enable Obfuscation

```bash
flutter build apk --release --obfuscate --split-debug-info=build/debug-symbols
flutter build ios --release --obfuscate --split-debug-info=build/debug-symbols
```

---

## CI/CD Integration

### GitHub Actions Example

`.github/workflows/build.yml`:
```yaml
name: Build & Release

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.9.2'
      - run: flutter pub get
      - run: flutter test
      - run: flutter build apk --release
      - uses: actions/upload-artifact@v3
        with:
          name: apk
          path: build/app/outputs/flutter-apk/app-release.apk

  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.9.2'
      - run: flutter pub get
      - run: cd ios && pod install
      - run: flutter build ios --release --no-codesign
```

---

## Release Checklist

- [ ] Update version in `pubspec.yaml`
- [ ] Update `CHANGELOG.md`
- [ ] Test on physical Android device
- [ ] Test on physical iOS device
- [ ] Test all core features (chat, livestream, quiz, notifications)
- [ ] Verify permissions work correctly
- [ ] Check app size (APK/IPA)
- [ ] Test with different screen sizes
- [ ] Test dark mode
- [ ] Test different locales (vi/en)
- [ ] Build release APK/AAB
- [ ] Build release IPA
- [ ] Upload to Google Play (internal test)
- [ ] Upload to TestFlight
- [ ] Get beta tester feedback
- [ ] Submit for production review

---

## Support

For build issues:
1. Check `flutter doctor` output
2. Clean build: `flutter clean && flutter pub get`
3. Check GitHub Issues
4. Contact dev team

**Last Updated:** October 2025  
**Flutter Version:** 3.9.2
