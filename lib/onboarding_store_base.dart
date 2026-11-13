/// Mémorise si l'onboarding a déjà été parcouru.
abstract interface class OnboardingStore {
  /// Vrai si l'utilisateur a déjà terminé ou passé l'onboarding.
  Future<bool> hasCompleted();

  /// Enregistre le passage de l'onboarding.
  Future<void> markCompleted();
}
