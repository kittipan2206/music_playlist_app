import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:music_playlist_app/main.dart';
import 'package:music_playlist_app/models/music_model.dart';
import 'package:music_playlist_app/screens/home.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music_playlist_app/services/music_player_service.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final BoxController boxController = BoxController();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    boxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    double appBarHeight = MediaQuery.of(context).size.height * 0.1;
    if (appBarHeight < 85) appBarHeight = 85;
    double minHeightBox = 70;
    double maxHeightBox = MediaQuery.of(context).size.height - appBarHeight;
    //
    return Scaffold(
      body: SlidingBox(
        controller: boxController,
        minHeight: minHeightBox,
        maxHeight: maxHeightBox,
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        backdrop: Backdrop(
          fading: true,
          overlay: false,
          body: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 0),
            child: Home(),
          ),
          appBar: BackdropAppBar(
            title: Container(
              margin: const EdgeInsets.only(left: 15),

              child: Text(
                "Music Music Playlist",
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        draggableIconVisible: false,
        collapsed: true,
        body: _body(height: maxHeightBox),
        collapsedBody: Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          child: _collapsedBody(),
        ),
      ),
    );
  }

  _body({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withAlpha(
              MyApp.themeMode == ThemeMode.light ? 150 : 200,
            ),
            MyApp.themeMode == ThemeMode.light
                ? Theme.of(context).colorScheme.onSurface.withAlpha(15)
                : Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (boxController.isAttached) boxController.closeBox();
                  },
                  color: Theme.of(context).colorScheme.onSurface,
                  iconSize: 24,
                  icon: const Icon(CupertinoIcons.chevron_down),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Duration?>(
              stream: MusicPlayerService.positionStream,
              builder: (context, asyncSnapshot) {
                final MusicModel? currentSong =
                    MusicPlayerService.getCurrentSong();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      constraints: BoxConstraints(
                        maxWidth: 500,
                        maxHeight: 500,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(30),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      // child: Image.asset(
                      //   "assets/images/music_player/music.jpg",
                      //   fit: BoxFit.cover,
                      // ),
                      child: Icon(
                        Icons.music_note,
                        size: MediaQuery.of(context).size.width / 2,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        // "Title",
                        currentSong != null
                            ? currentSong.title ?? "Unknown Title"
                            : "Unknown Title",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      child: Text(
                        // "Artist, Album",
                        currentSong != null
                            ? currentSong.artist ?? 'Unknown Artist'
                            : "Unknown Artist, Unknown Album",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: height * 0.3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.music_note_list,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.heart,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: StreamBuilder<Duration?>(
                    stream: MusicPlayerService.positionStream,
                    builder: (context, snapshot) {
                      final valueDuration =
                          snapshot.data?.inMilliseconds.toInt() ?? 0;
                      final maxDuration = MusicPlayerService.getDuration()
                          ?.inMilliseconds
                          .toInt();

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProgressBar(
                          timeLabelTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          progress: Duration(milliseconds: valueDuration),
                          total: Duration(milliseconds: maxDuration ?? 1),
                          barHeight: 3,
                          baseBarColor: Colors.white.withAlpha(100),
                          progressBarColor: Colors.orangeAccent,
                          thumbColor: Colors.white,
                          onSeek: (duration) {
                            MusicPlayerService.seek(duration);
                          },
                          onDragStart: (duration) {
                            MusicPlayerService.pause();
                          },
                          onDragEnd: () {
                            MusicPlayerService.resume();
                          },
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StreamBuilder<bool>(
                      stream: MusicPlayerService.shuffleModeStream,
                      builder: (context, asyncSnapshot) {
                        return IconButton(
                          onPressed: () {
                            if (asyncSnapshot.data == true) {
                              MusicPlayerService.unshuffle();
                            } else {
                              MusicPlayerService.shuffle();
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.shuffle,
                            // color: Colors.white,
                            color: asyncSnapshot.data == true
                                ? Colors.orangeAccent
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        MusicPlayerService.skipPrevious();
                      },
                      icon: const Icon(
                        CupertinoIcons.backward_end_alt_fill,
                        color: Colors.white,
                      ),
                    ),

                    StreamBuilder<PlayerState>(
                      stream: MusicPlayerService.playerStateStream,
                      builder: (context, snapshot) {
                        final state = snapshot.data;
                        return IconButton(
                          icon: Icon(
                            state?.playing == true
                                ? CupertinoIcons.pause_solid
                                : CupertinoIcons.play_arrow_solid,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () => state?.playing == true
                              ? MusicPlayerService.pause()
                              : MusicPlayerService.resume(),
                        );
                      },
                    ),

                    IconButton(
                      onPressed: () {
                        MusicPlayerService.skipNext();
                      },
                      disabledColor: MusicPlayerService.isLastSong()
                          ? Colors.grey
                          : Colors.white,
                      icon: const Icon(
                        CupertinoIcons.forward_end_alt_fill,
                        color: Colors.white,
                      ),
                    ),
                    StreamBuilder<LoopMode>(
                      stream: MusicPlayerService.repeatModeStream,
                      builder: (context, asyncSnapshot) {
                        return IconButton(
                          onPressed: () {
                            if (asyncSnapshot.data == LoopMode.one) {
                              MusicPlayerService.unrepeat();
                            } else {
                              MusicPlayerService.repeat();
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.repeat,
                            color: asyncSnapshot.data == LoopMode.one
                                ? Colors.orangeAccent
                                : Colors.white,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _collapsedBody() {
    return GestureDetector(
      onTap: () {
        if (boxController.isBoxClosed) boxController.openBox();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35)),
          color: Colors.black,
        ),
        child: Column(
          children: [
            StreamBuilder<Duration?>(
              stream: MusicPlayerService.positionStream,
              builder: (context, snapshot) {
                final maxDuration =
                    MusicPlayerService.getDuration()?.inMilliseconds.toInt() ??
                    1;
                return Expanded(
                  child: ProgressBar(
                    progress: Duration(
                      milliseconds: snapshot.data?.inMilliseconds ?? 0,
                    ),
                    total: Duration(milliseconds: maxDuration),
                    barHeight: 3,
                    baseBarColor: Colors.white.withAlpha(100),
                    progressBarColor: Colors.white,
                    thumbColor: Colors.transparent,
                    onSeek: (duration) {
                      MusicPlayerService.seek(duration);
                    },
                    // onDragStart: (duration) {
                    //   MusicPlayerService.pause();
                    // },
                    // onDragEnd: () {
                    //   MusicPlayerService.resume();
                    // },
                  ),
                );
              },
            ),
            _controller(),
          ],
        ),
      ),
    );
  }

  _controller() {
    return StreamBuilder<int?>(
      stream: MusicPlayerService.currentIndexStream,
      builder: (context, asyncSnapshot) {
        final MusicModel? currentSong = MusicPlayerService.getCurrentSong();
        return Row(
          children: [
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),

              // child: currentSong?.coverImage != null
              //     ? ClipRRect(
              //         borderRadius: BorderRadius.circular(40),
              //         child: Image.memory(
              //           currentSong!.coverImage!.bytes,
              //           fit: BoxFit.cover,
              //         ),
              //       )
              //     : const Icon(Icons.music_note, size: 40, color: Colors.white),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (currentSong?.coverImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.memory(
                        currentSong!.coverImage!.bytes,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Icon(Icons.music_note, size: 40, color: Colors.white),
                  Opacity(
                    opacity: 0.5,
                    child: Lottie.asset(
                      'assets/lotties/music_orange.json',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentSong != null
                        ? currentSong.title ?? "Unknown Title"
                        : "Unknown Title",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    currentSong != null
                        ? currentSong.artist ?? 'Unknown Artist'
                        : "Unknown Artist, Unknown Album",
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    MusicPlayerService.skipPrevious();
                  },
                  icon: const Icon(
                    CupertinoIcons.backward_end_alt_fill,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                StreamBuilder<PlayerState>(
                  stream: MusicPlayerService.playerStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    return IconButton(
                      icon: Icon(
                        state?.playing == true
                            ? CupertinoIcons.pause_solid
                            : CupertinoIcons.play_arrow_solid,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () => state?.playing == true
                          ? MusicPlayerService.pause()
                          : MusicPlayerService.resume(),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    MusicPlayerService.skipNext();
                  },
                  icon: const Icon(
                    CupertinoIcons.forward_end_alt_fill,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
