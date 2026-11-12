# Benin Vibes

Application mobile Flutter de streaming musical dédiée à la scène béninoise : une bibliothèque locale, un lecteur audio complet, des paroles synchronisées et une interface pensée mobile-first.

> Projet de portfolio — démonstration de compétences en Flutter/Dart, architecture applicative, persistance SQLite et design d'interface.

## Aperçu

Benin Vibes met en avant des artistes du Bénin (Afro-folk, Afropop, Gospel, Traditionnel, World, Tchink System) à travers une expérience d'écoute soignée :

- **Onboarding** animé au premier lancement, mémorisé sur l'appareil
- **Accueil** avec sélections éditoriales, genres et artistes
- **Lecteur complet** : lecture, pause, seek, piste suivante/précédente, file de lecture, mini-player persistant
- **Paroles synchronisées** affichées en temps réel selon la position audio
- **Favoris** persistés en base SQLite
- **Recherche** dans la bibliothèque (morceaux, artistes, genres)
- **Thème sombre** cohérent, typographie Outfit, animations fluides

## Stack technique

| Couche | Technologie |
| --- | --- |
| UI | Flutter / Material 3, Dart 3 |
| Audio | [`just_audio`](https://pub.dev/packages/just_audio) |
| Base de données | [`sqflite`](https://pub.dev/packages/sqflite) (SQLite local) |
| Fichiers | [`path_provider`](https://pub.dev/packages/path_provider), [`path`](https://pub.dev/packages/path) |
| Tests | `flutter_test`, `sqflite_common_ffi` |

## Architecture

```
lib/
├── main.dart                  # Bootstrap : DB, seed, audio, onboarding
├── home_shell.dart            # Navigation, onglets, mini-player
├── now_playing_sheet.dart     # Lecteur plein écran + paroles
├── player_controller.dart     # État de lecture (ChangeNotifier)
├── artist_page.dart           # Fiche artiste
├── genre_page.dart            # Fiche genre
├── onboarding_page.dart       # Premier lancement
├── theme.dart                 # Design system (couleurs, typographies)
├── data.dart                  # Modèles métier (Track, Artist, Genre…)
├── audio/                     # Abstraction du moteur audio
│   ├── audio_engine.dart
│   ├── just_audio_engine.dart
│   ├── audio_source_resolver.dart
│   └── source_switch_queue.dart
└── database/                  # Persistance SQLite
    ├── app_database.dart      # Schéma v2 + migrations + seed
    ├── library_repository.dart
    └── library_seed.dart
```

Principes appliqués :

- **Séparation des responsabilités** : le moteur audio est derrière une interface (`AudioEngine`), ce qui permet de le remplacer par un faux moteur dans les tests.
- **Repository pattern** : la couche SQLite est isolée du reste de l'application.
- **Seed embarqué** : au premier lancement, la bibliothèque est injectée depuis `assets/data/library.json` puis servie par SQLite.
- **Fallback robuste** : si SQLite est indisponible, l'application charge directement le seed JSON.

### Schéma de base de données

- `genres` — table de référence des styles musicaux
- `artists` — artistes
- `tracks` — morceaux, avec clés étrangères vers `artists` et `genres`, plus la colonne `liked` pour les favoris
- Contraintes `ON DELETE RESTRICT` + `PRAGMA foreign_keys = ON` pour garantir l'intégrité

## Lancer le projet

Prérequis : Flutter SDK ≥ 3.13.

```bash
flutter pub get
flutter run
```

Cibles supportées : Android, iOS, Web, Windows, macOS, Linux.

## Tests

```bash
flutter test
flutter analyze
```

La suite couvre la base de données, le seed, la recherche, le contrôleur de lecture, la file de changement de source et l'interface.

## Contenu et droits

Les morceaux audio et les pochettes présents dans `assets/` sont utilisés à titre de démonstration et restent la propriété de leurs artistes et ayants droit respectifs. Ils ne sont pas couverts par la licence du code et ne doivent pas être réutilisés en dehors de ce projet.

> **Démo en ligne** : pour garder le dépôt léger, seuls trois extraits d'environ 30 secondes sont versionnés (`*.preview.mp3`) — trois morceaux avec paroles synchronisées, un par artiste. Les autres titres de la bibliothèque sont visibles dans l'interface mais leurs fichiers audio restent locaux.

## Auteur

**Boris Idako** — [GitHub @IDAKO514](https://github.com/IDAKO514)
