# Music Playlist App

A Flutter project for a music playlist application that allows users to browse tracks, create and manage playlists, and play music with an intuitive interface. The app is built using Flutter and Dart, targeting both Android and iOS platforms.

## Features

- View list of songs
- Create and manage playlists
- Play, pause, skip tracks
- Persistent storage of playlists
- Responsive UI for mobile devices

## Getting Started

Follow these steps to run the application on your local machine.

### Prerequisites

- Flutter SDK installed (https://flutter.dev/docs/get-started/install)
- Android Studio or Visual Studio Code with Flutter and Dart plugins
- A device or emulator for testing

### Installation

1. Clone the repository

git clone https://github.com/your-username/music-playlist-app.git
cd music-playlist-app

2. Get Flutter dependencies

flutter pub get

3. Run the app

For Android:

flutter run

For iOS:

flutter run

4. (Optional) Build an APK

flutter build apk

## Project Structure

lib/
├── main.dart
├── models/            // Data models like Song and Playlist
├── screens/           // Application screens
├── widgets/           // Reusable UI components
├── services/          // Logic for audio playback and storage
└── utils/             // Constants and utility functions

## Dependencies

This app uses the following Dart packages:

- just_audio: Audio playback
- provider: State management
- shared_preferences: Local storage
- path_provider: Access device storage

Make sure all dependencies are listed in pubspec.yaml and are installed using flutter pub get.

## Permissions

Ensure the following permissions are added:

For Android (in android/app/src/main/AndroidManifest.xml):

<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

For iOS (in ios/Runner/Info.plist):

<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
<key>NSMicrophoneUsageDescription</key>
<string>This app requires microphone access for audio playback</string>

## License

This project is open-source and available under the MIT License. See the LICENSE file for more details.
