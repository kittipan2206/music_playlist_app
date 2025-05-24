import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_playlist_app/models/music_model.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({
    super.key,
    required this.music,
    required this.currentPlayingIndex,
    required this.index,
    required this.onTap,
  });

  final MusicModel music;
  final int currentPlayingIndex;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          if (music.coverImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.memory(
                music.coverImage!.bytes,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          else
            const Icon(Icons.music_note, size: 40),
          if (currentPlayingIndex == index)
            Positioned(
              right: 0,
              bottom: 0,
              child: Lottie.asset(
                'assets/lotties/music_orange.json',
                width: 20,
                height: 20,
              ),
            ),
        ],
      ),
      title: Text(
        music.title ?? 'Unknown Title',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: currentPlayingIndex == index ? Colors.orangeAccent : null,
        ),
      ),
      subtitle: Text(
        music.artist ?? 'Unknown Artist',
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
      ),
      onTap: onTap,
    );
  }
}
