# Music Playlist App

A cross-platform Flutter app for managing and playing music with background audio and notification support. Enjoy your favorite tracks with a modern, responsive interface on Android and iOS.

## Features

- Play, pause, skip, and seek music tracks
- Reads music from bundled assets
- Clean, mobile-optimized UI

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio, VS Code, or any IDE with Flutter support
- Android/iOS device or emulator

### Installation

```bash
# Clone the repository
git clone https://github.com/kittipan2206/music_playlist_app.git
cd music_playlist_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Building for Production

```bash
# Android APK
flutter build apk

# iOS
flutter build ios
```

## Project Structure

```
lib/
├── main.dart          # App entry point
├── models/            # Data models
├── screens/           # UI screens
├── widgets/           # Reusable widgets
├── services/          # Audio, music, and background logic
└── utils/             # Helper utilities
```

## Dependencies

- **just_audio**: Audio playback
- **provider**: State management
- **shared_preferences**: Local storage
- **path_provider**: File system access
- **permission_handler**: Runtime permissions
- **audio_metadata_reader**: Read music metadata

## Permissions

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

MIT License. See LICENSE for details.
