import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicProvider extends InheritedWidget {
  final player = AudioPlayer();
  ValueNotifier<Duration> totalDuration = ValueNotifier(Duration.zero);
  ValueNotifier<Duration> position = ValueNotifier(Duration.zero);
  ValueNotifier<int> _currentSongIndex = ValueNotifier(0);
  ValueNotifier<bool> playing = ValueNotifier(false);
  ValueNotifier<bool> loaded = ValueNotifier(false);
  ValueNotifier<bool> isPanelVisible = ValueNotifier(false);
  final List<String> _songList = [
    'music/clear-mind.mp3',
    'music/chill-medium.mp3',
    'music/chill.mp3',
    'music/close-chillhop.mp3',
    'music/eco-tech.mp3',
    'music/home.mp3',
    'music/morning-garden.mp3',
    'music/ocean-choir.mp3',
    'music/one-more-step.mp3',
    'music/please-calm-my-mind.mp3',
    'music/pomodor.mp3',
    'music/science-doc.mp3',
    'music/sleepy-cat.mp3',
    'music/street-food.mp3',
    'music/sweet-darling.mp3',
    'music/valley-of-hope.mp3',
    'music/weekend-vibes.mp3',
    'music/you-have-it.mp3',
    'music/chillhop.mp3',
  ];
  MusicProvider._internal({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {
    _init();
  }

  static final MusicProvider _instance = MusicProvider._internal(child: SizedBox());

  static MusicProvider get instance => _instance;

  void _init() {
    player.onDurationChanged.listen((duration) {
      totalDuration.value = duration;
    });
    player.onPositionChanged.listen((pos) {
      position.value = pos;
    });
    player.onPlayerComplete.listen((event) {
      pauseMusic();
      nextSong();
      playMusic();
    });
  }


  Future<void> playMusic() async {
    if (!playing.value) {
      await player.play(AssetSource(_songList[_currentSongIndex.value]));
      playing.value = true;
    }
  }

  Future<void> pauseMusic() async {
    await player.pause();
    playing.value = false;
  }
  Future<void> nextSong() async {
    if (_currentSongIndex.value < _songList.length - 1) {
      _currentSongIndex.value++;
    } else {
      _currentSongIndex.value = 0;
    }
    player.stop();
    await player.play(AssetSource(_songList[_currentSongIndex.value]));
    playing.value = true;
  }

  Future<void> previousSong() async{
    if(position.value.inSeconds.toDouble() > 10){
      player.seek(Duration(seconds: 0));
    }
    else{
      if (_currentSongIndex.value > 0) {
        _currentSongIndex.value--;
      } else {
        player.seek(Duration(seconds: 0));
      }
    }
    player.stop();
    await player.play(AssetSource(_songList[_currentSongIndex.value]));
    playing.value = true;

  }
  @override
  void dispose() {
    pauseMusic();
    player.dispose();
  }
  static MusicProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MusicProvider>();
  }

  @override
  bool updateShouldNotify(MusicProvider oldWidget) {
    return player != oldWidget.player;
  }

  void togglePanel() {
    isPanelVisible.value = !isPanelVisible.value;
  }
}

class Music extends StatefulWidget {
  Music({Key? key}) : super(key: key);
  @override
  _MusicState createState() => _MusicState();
}
class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    var musicProvider = MusicProvider.instance;
    return Stack(
      children: [
         Positioned(
            top: 33,
            right: 20,
            child : Material(
              color: Colors.transparent,
              child: OutlinedButton(
                onPressed: () => musicProvider?.togglePanel(),
                child: Icon(
                    Icons.music_note_sharp,
                    color: Colors.black,
                ),
                style:  ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent)
                  )
              )
            )
          ),
        Positioned(
          top: 78,
          right: 0,
          child: ValueListenableBuilder<bool>(
            valueListenable: musicProvider.isPanelVisible ?? ValueNotifier<bool>(false),
            builder: (context, isPanelVisible, child) {
              double panelWidth = MediaQuery.of(context).size.width;
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: musicProvider.togglePanel,
                child: Stack(
                  children: [
                    if(isPanelVisible)
                      Container(
                        color: Colors.transparent, // semi-transparente para ver efecto
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    AnimatedContainer(
                      width: isPanelVisible ? panelWidth : 0,
                      duration: Duration(milliseconds: 300),
                      height: 200,
                      curve: Curves.easeInOut,
                      child: isPanelVisible ? MusicPlayerWidget(onClose: musicProvider.togglePanel) : null,
                    )
                  ],
                )
              );
            },
          ),
        ),
      ],
    );
  }
}

class MusicPlayerWidget extends StatelessWidget {
  final VoidCallback onClose;

  MusicPlayerWidget({required this.onClose});
  @override
  Widget build(BuildContext context) {
    var musicProvider = MusicProvider.instance;
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(80)),
        color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(80)),
        ),
        height: 200,
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.library_music,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ValueListenableBuilder<int>(
                      valueListenable: musicProvider?._currentSongIndex as ValueNotifier<int>,
                      builder: (context, currentSongIndex, child) {
                        return Text(
                          '   ${parseMusicFileName(musicProvider?._songList[currentSongIndex] as String)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<Duration>(
              valueListenable: musicProvider?.position as ValueNotifier<Duration>,
              builder: (context, position, child) {
                return Material(
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  color: Colors.white,
                  child: Slider(
                    activeColor: Colors.amber,
                    thumbColor: Colors.amber,
                    inactiveColor: Colors.grey,
                    value: position.inSeconds.toDouble(),
                    max: (musicProvider?.totalDuration.value as Duration).inSeconds.toDouble(),
                    onChanged: (value) {
                      musicProvider?.player.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.skip_previous, size: 36),
                    onPressed: ()=> musicProvider?.previousSong(),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: musicProvider?.playing as ValueNotifier<bool>,
                    builder: (context, playing, child) {
                      return IconButton(
                        icon: Icon(playing ? Icons.pause : Icons.play_arrow, size: 36),
                        onPressed: () => playing ? musicProvider?.pauseMusic() : musicProvider?.playMusic(),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.skip_next, size: 36),
                    onPressed: ()=> musicProvider?.nextSong(),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 1),
          ],
        ),
      )
    );
  }
}
String parseMusicFileName(String filePath) {
  String fileName = filePath.split('/').last.split('.').first;
  return fileName.split('-').map((String word) {
    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}

