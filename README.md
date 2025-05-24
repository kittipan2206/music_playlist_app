# Music Playlist App

A cross-platform mobile application built with Flutter for managing and playing music. This app provides an intuitive interface for browsing tracks, creating playlists, and enjoying music on both Android and iOS devices.

## Features

- Browse and search music tracks
- Create, edit, and delete playlists
- Full playback controls (play, pause, skip)
- Save playlists locally for offline access
- Clean, responsive interface optimized for mobile

## Getting Started

### Prerequisites

- Flutter SDK (follow [installation guide](https://flutter.dev/docs/get-started/install))
- IDE with Flutter support (Android Studio, VS Code)
- Mobile device or emulator

### Installation

```bash
# Clone repository
git clone https://github.com/your-username/music-playlist-app.git
cd music-playlist-app

# Install dependencies
flutter pub get

# Run application
flutter run
```

### Building for Production

```bash
# Android APK
flutter build apk

# iOS
flutter build ios
```

## 📁 Project Structure

```
lib/
├── main.dart          # Entry point
├── models/            # Data models
├── screens/           # App screens
├── widgets/           # UI components
├── services/          # Business logic
└── utils/             # Helper functions
```

## Dependencies

- **just_audio**: Audio playback functionality
- **provider**: State management
- **shared_preferences**: Local data persistence
- **path_provider**: File system access

## Required Permissions

### Android
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

### iOS
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>NSMicrophoneUsageDescription</key>
<string>This app requires microphone access for audio playback</string>
```

## License

Released under the MIT License. See LICENSE file for details.
