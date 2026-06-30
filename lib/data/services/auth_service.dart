import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

/// Low-level wrapper around Firebase Auth + Google Sign-In (v7 API).
///
/// The rest of the app talks to [AuthRepository], never to this class
/// directly, so the authentication backend can be replaced without touching
/// UI or view-models.
///
/// ### Demo fallback
/// Real Google authentication requires a configured Firebase project
/// (`google-services.json` / `GoogleService-Info.plist` and an OAuth client).
/// When that configuration is missing — as in a fresh checkout used purely to
/// demo the UI flow — [enableDemoFallback] lets the sign-in resolve to a mock
/// user so the Splash → Login → Home navigation can still be recorded.
/// Now that a real Firebase project is attached it defaults to `false`.
class AuthService {
  AuthService({this.enableDemoFallback = false});

  /// When `true`, a missing/failed Firebase configuration falls back to a mock
  /// user instead of surfacing an error. Kept `false` in production.
  final bool enableDemoFallback;

  /// Web (server) OAuth client ID — required on **Android** so Google returns
  /// an `idToken` Firebase can consume. Find it in `google-services.json` under
  /// `oauth_client` with `"client_type": 3`, or in the Google Cloud console as
  /// the "Web client (auto created by Google Service)". Harmless on iOS, where
  /// the client ID is also read from `GoogleService-Info.plist`.
  static const String googleServerClientId =
      '419862673797-8i0c1t95fbo22qtrumlta9fvlhtda5dj.apps.googleusercontent.com';

  bool _googleInitialized = false;

  FirebaseAuth? get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (_) {
      // Firebase.initializeApp() was never called (no config present).
      return null;
    }
  }

  /// The currently signed-in user, if any.
  UserModel? get currentUser {
    final User? user = _auth?.currentUser;
    if (user == null) return null;
    return _mapFirebaseUser(user);
  }

  /// Lazily initialize the Google Sign-In singleton exactly once.
  ///
  /// On iOS the client ID is discovered from `GoogleService-Info.plist`; on
  /// Android we pass [googleServerClientId] so the returned credential carries
  /// an `idToken` for Firebase.
  Future<void> _ensureGoogleInitialized() async {
    if (_googleInitialized) return;
    await GoogleSignIn.instance.initialize(
      serverClientId: googleServerClientId,
    );
    _googleInitialized = true;
  }

  /// Run the full Google → Firebase credential exchange.
  ///
  /// Returns the authenticated [UserModel], or `null` if the user cancelled
  /// the Google account picker.
  Future<UserModel?> signInWithGoogle() async {
    try {
      await _ensureGoogleInitialized();

      // Throws GoogleSignInException(code: canceled) if the user backs out.
      final GoogleSignInAccount account =
          await GoogleSignIn.instance.authenticate(
        scopeHint: <String>['email', 'profile'],
      );

      final String? idToken = account.authentication.idToken;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      final FirebaseAuth? auth = _auth;
      if (auth == null) {
        // Firebase not configured — fall back to a model built from the
        // Google account so the demo can proceed.
        if (enableDemoFallback) return _demoUserFromGoogle(account);
        throw StateError('Firebase is not initialized.');
      }

      final UserCredential result = await auth.signInWithCredential(credential);
      final User? user = result.user;
      if (user == null) return null;
      return _mapFirebaseUser(user);
    } on GoogleSignInException catch (e, s) {
      // User cancelled the picker — treat as a no-op, not an error.
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      debugPrint('GoogleSignInException [${e.code}]: ${e.description}\n$s');
      if (enableDemoFallback) return _demoUser();
      rethrow;
    } catch (e, s) {
      // Any other failure (missing OAuth client, network in offline demo, …).
      debugPrint('Google sign-in failed: $e\n$s');
      if (enableDemoFallback) return _demoUser();
      rethrow;
    }
  }

  /// Sign the user out of both Firebase and Google.
  Future<void> signOut() async {
    try {
      await _auth?.signOut();
      if (_googleInitialized) {
        await GoogleSignIn.instance.signOut();
      }
    } catch (_) {
      // Best-effort sign out; ignore if the providers were never configured.
    }
  }

  UserModel _mapFirebaseUser(User user) => UserModel(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
      );

  UserModel _demoUserFromGoogle(GoogleSignInAccount account) => UserModel(
        uid: account.id,
        name: account.displayName ?? account.email.split('@').first,
        email: account.email,
        photoUrl: account.photoUrl,
      );

  UserModel _demoUser() => const UserModel(
        uid: 'demo-user',
        name: 'Sofia Chen',
        email: 'sofia.chen@alive.demo',
        photoUrl: null,
      );
}
