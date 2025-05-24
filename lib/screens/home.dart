import 'package:flutter/material.dart';
import 'package:music_playlist_app/models/music_model.dart';
import 'package:music_playlist_app/services/music_finder_service.dart';
import 'package:music_playlist_app/services/music_player_service.dart';
import 'package:music_playlist_app/widgets/music_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _loadMusicFiles();
    super.initState();
  }

  Future<List<MusicModel>> _loadMusicFiles() async {
    try {
      final musicFiles = await MusicService.findMusicFiles();
      return musicFiles;
    } catch (e) {
      debugPrint('Error loading music files: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MusicModel>>(
      future: _loadMusicFiles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No music files found.'));
        } else {
          final musicList = snapshot.data!;
          return StreamBuilder<int?>(
            stream: MusicPlayerService.currentIndexStream,
            builder: (context, asyncSnapshot) {
              final currentPlayingIndex = asyncSnapshot.data ?? -1;
              return ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  final music = musicList[index];
                  return MusicItem(
                    music: music,
                    index: index,
                    currentPlayingIndex: currentPlayingIndex,
                    onTap: () {
                      MusicPlayerService.playPlaylist(musicList, index);
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
