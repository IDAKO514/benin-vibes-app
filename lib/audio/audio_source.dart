/// Résultat de la résolution d'une source audio.
class AudioSource {
  /// URI ou chemin lisible par `just_audio` (asset Flutter ou `file://...`).
  final String uri;

  /// Vrai si le fichier est un asset Flutter compilé (`assets/audio/...`).
  final bool isAsset;

  /// Vrai si le fichier est présent sur l'appareil (asset ou stockage local).
  final bool isLocal;

  const AudioSource({
    required this.uri,
    this.isAsset = false,
    this.isLocal = true,
  });
}
