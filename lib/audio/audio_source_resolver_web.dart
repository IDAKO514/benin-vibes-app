import 'package:path/path.dart' as p;

import '../data.dart';
import 'audio_source.dart';

/// Version web : pas de stockage externe, l'audio vient des assets servis
/// par le navigateur.
class AudioSourceResolver {
  AudioSourceResolver({Object? externalDirectory});

  /// Résout [track], ou `null` si aucune source n'est disponible.
  Future<AudioSource?> resolve(Track track) async {
    final name = p.basename(track.audioPath);
    if (name.isEmpty || name == '.') return null;
    return AudioSource(uri: 'assets/audio/$name', isAsset: true, isLocal: true);
  }
}
