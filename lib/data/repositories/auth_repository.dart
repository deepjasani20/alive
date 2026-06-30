import '../models/user_model.dart';
import '../services/auth_service.dart';

/// Repository that exposes authentication use-cases to the presentation layer.
///
/// View-models depend on this abstraction rather than on [AuthService] (and by
/// extension Firebase), which keeps the MVVM layers cleanly separated and makes
/// the code trivial to unit-test with a fake repository.
class AuthRepository {
  AuthRepository({AuthService? service}) : _service = service ?? AuthService();

  final AuthService _service;

  /// The user restored from a previous session, if still signed in.
  UserModel? get currentUser => _service.currentUser;

  bool get isLoggedIn => _service.currentUser != null;

  /// Sign in with Google. Returns `null` if the user cancels.
  Future<UserModel?> signInWithGoogle() => _service.signInWithGoogle();

  Future<void> signOut() => _service.signOut();
}
