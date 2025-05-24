import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_playlist_app/models/music_model.dart';
import 'package:music_playlist_app/services/music_finder_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MusicPlayerService {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  /// Play a single track
  static Future<void> play(MusicModel song) async {
    try {
      // clear previous audio source
      await _audioPlayer.clearAudioSources();

      // set new audio source
      await _audioPlayer.setAudioSource(AudioSource.asset(song.filePath!));
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("Error playing song: $e");
    }
  }

  /// Play a playlist by index
  static Future<void> playPlaylist(List<MusicModel> playlist, int index) async {
    try {
      // clear previous audio source
      await _audioPlayer.clearAudioSources();

      // set new audio source
      await _audioPlayer.setAudioSources(
        playlist.map((song) => AudioSource.asset(song.filePath!)).toList(),
        initialIndex: index,
      );
      await _audioPlayer.play();
    } catch (e) {
      Fluttertoast.showToast(msg: "Error playing playlist: $e");
    }
  }

  // check if the song is already playing
  static bool isPlaying() {
    return _audioPlayer.playing;
  }

  /// Control methods
  static Future<void> pause() => _audioPlayer.pause();
  static Future<void> resume() => _audioPlayer.play();
  static Future<void> stop() => _audioPlayer.stop();
  static Future<void> seek(Duration position) => _audioPlayer.seek(position);
  static Future<void> skipNext() => _audioPlayer.seekToNext();
  static Future<void> skipPrevious() => _audioPlayer.seekToPrevious();
  static Future<void> shuffle() => _audioPlayer.setShuffleModeEnabled(true);
  static Future<void> unshuffle() => _audioPlayer.setShuffleModeEnabled(false);
  static Future<void> repeat() => _audioPlayer.setLoopMode(LoopMode.one);
  static Future<void> unrepeat() => _audioPlayer.setLoopMode(LoopMode.off);

  // stream shuffle mode
  static Stream<bool> get shuffleModeStream =>
      _audioPlayer.shuffleModeEnabledStream;

  // stream repeat mode
  static Stream<LoopMode> get repeatModeStream => _audioPlayer.loopModeStream;

  // is last song
  static bool isLastSong() {
    final currentIndex = _audioPlayer.currentIndex;
    final playlistLength = _audioPlayer.sequence.length;
    return currentIndex == playlistLength - 1;
  }

  // is first song
  static bool isFirstSong() {
    final currentIndex = _audioPlayer.currentIndex;
    return currentIndex == 0;
  }

  // get song duration
  static Duration? getDuration() {
    final duration = _audioPlayer.duration;
    return duration;
  }

  /// Player state stream
  static Stream<PlayerState> get playerStateStream =>
      _audioPlayer.playerStateStream;

  /// Current position stream
  static Stream<Duration?> get positionStream => _audioPlayer.positionStream;

  /// stream
  static Stream<int?> get currentIndexStream => _audioPlayer.currentIndexStream;

  /// Current playing song
  static MusicModel? getCurrentSong() {
    final List<MusicModel> musicList = MusicService.musicList;
    final currentIndex = _audioPlayer.currentIndex;
    if (currentIndex != null && currentIndex < musicList.length) {
      return musicList[currentIndex];
    }
    return null;
  }

  // get current index
  static int? getCurrentIndex() {
    return _audioPlayer.currentIndex;
  }
}
