import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:music_playlist_app/models/music_model.dart';
import 'package:music_playlist_app/utils/duration_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:audio_metadata_reader/audio_metadata_reader.dart';

class MusicService {
  static List<MusicModel> musicList = [];

  /// Request storage permission
  static Future<bool> requestPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final status = await Permission.audio.request();
      if (status.isDenied) {
        // Permission denied, show a message to the user
        return false;
      } else if (status.isPermanentlyDenied) {
        // Permission permanently denied, open app settings
        await openAppSettings();
        return false;
      }
      return status.isGranted;
    }
    return true;
  }

  /// Find music files in external storage
  static Future<List<MusicModel>> findMusicFiles() async {
    // check music in flutter assets
    final musicList = <MusicModel>[];
    try {
      final assetMusicList = await loadAssetMusicFiles();
      musicList.addAll(assetMusicList);
    } catch (e) {
      debugPrint('Error loading asset music files: $e');
    }

    MusicService.musicList = musicList;
    return musicList;
  }

  static Future<List<MusicModel>> loadAssetMusicFiles() async {
    final manifest = await rootBundle.loadString('AssetManifest.json');
    final musicPaths = <String>[];
    final musicMap = json.decode(manifest) as Map<String, dynamic>;
    musicMap.forEach((key, value) {
      if (_isMusicFile(key)) {
        musicPaths.add(key);
      }
    });
    final List<MusicModel> musicList = [];
    for (final path in musicPaths) {
      try {
        // final track = File(path);
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/$path');
        await file.create(recursive: true);
        final byteData = await rootBundle.load(path);
        await file.writeAsBytes(byteData.buffer.asUint8List());
        final track = file;
        final metadata = readMetadata(track, getImage: true);
        final music = MusicModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: metadata.title ?? path.split('/').last,
          artist: metadata.artist ?? 'Unknown',
          album: metadata.album ?? 'Unknown',
          year: metadata.year?.year,
          duration: DurationUtils.formatDuration(
            metadata.duration ?? Duration.zero,
          ),
          genre: metadata.genres.join(', '),
          filePath: path,
          coverImage: metadata.pictures.isNotEmpty
              ? metadata.pictures.first
              : null,
        );
        musicList.add(music);
      } catch (e) {
        // Fallback if metadata can't be read
        musicList.add(
          MusicModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: path.split('/').last,
            artist: 'Unknown',
            album: 'Unknown',
            genre: 'Unknown',
            year: null,
            duration: null,
            filePath: path,
          ),
        );
      }
    }
    return musicList;
  }

  /// Check file extensions
  static bool _isMusicFile(String path) {
    const extensions = ['.mp3', '.wav', '.aac', '.flac', '.m4a'];
    return extensions.any((ext) => path.toLowerCase().endsWith(ext));
  }
}
