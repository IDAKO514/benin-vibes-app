import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'onboarding_store_base.dart';

/// Implémentation par fichier, sans dépendance supplémentaire.
class FileOnboardingStore implements OnboardingStore {
  final Future<Directory> Function() _directory;

  FileOnboardingStore({Future<Directory> Function()? directory})
    : _directory = directory ?? getApplicationSupportDirectory;

  static const _fileName = 'onboarding_completed';

  Future<File> _file() async =>
      File(p.join((await _directory()).path, _fileName));

  @override
  Future<bool> hasCompleted() async {
    try {
      return await (await _file()).exists();
    } catch (error) {
      // En cas d'échec, on propose l'onboarding plutôt que de bloquer l'accès.
      return false;
    }
  }

  @override
  Future<void> markCompleted() async {
    try {
      final file = await _file();
      await file.parent.create(recursive: true);
      await file.writeAsString('1');
    } catch (_) {
      // Le marqueur n'est pas indispensable : au pire, l'onboarding revient.
    }
  }
}
