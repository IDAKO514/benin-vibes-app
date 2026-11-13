import 'dart:html' as html;

import 'onboarding_store_base.dart';

/// Implémentation web : le marqueur est conservé dans `localStorage`.
class FileOnboardingStore implements OnboardingStore {
  FileOnboardingStore({Object? directory});

  static const _key = 'benin_vibes_onboarding_completed';

  @override
  Future<bool> hasCompleted() async {
    try {
      return html.window.localStorage.containsKey(_key);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> markCompleted() async {
    try {
      html.window.localStorage[_key] = '1';
    } catch (_) {
      // Le marqueur n'est pas indispensable : au pire, l'onboarding revient.
    }
  }
}
