import 'package:audioplayers/audioplayers.dart';

class SoundService {
  late final AudioPlayer _tap1Player;
  late final AudioPlayer _tap2Player;

  Future<void> init() async {
    _tap1Player = AudioPlayer();
    _tap2Player = AudioPlayer();

    await _tap1Player.setReleaseMode(ReleaseMode.stop);
    await _tap2Player.setReleaseMode(ReleaseMode.stop);

    await _tap1Player.setVolume(0.2);
    await _tap2Player.setVolume(0.2);

    // Preload sounds
    await _tap1Player.setSource(AssetSource('tap1.wav'));
    await _tap2Player.setSource(AssetSource('tap2.wav'));
  }

  Future<void> playTap1() async {
    await _tap1Player.seek(Duration.zero);
    await _tap1Player.resume();
  }

  Future<void> playTap2() async {
    await _tap2Player.seek(Duration.zero);
    await _tap2Player.resume();
  }
}
