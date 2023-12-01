import 'package:audioplayers/audioplayers.dart';

class SoundService {
  // private constructor
  SoundService._();

  /// Cached instance of [SoundService]
  static SoundService? _instance;

  /// return an instance of [SoundService]
  static SoundService get instance {
    // set the instance if it's null
    _instance ??= SoundService._();
    // return the instance
    return _instance!;
  }

  final _player = AudioCache();
  final player = AudioPlayer();

  Future<void> loadSounds() async {
    await _player.load(
      'audio/click_sound.mp3',
    );
  }

  Future<void> playTapDownSound() async {
    player.audioCache = _player;
    await player.play(
      AssetSource('audio/click_sound.mp3'),
    );
  }
}
