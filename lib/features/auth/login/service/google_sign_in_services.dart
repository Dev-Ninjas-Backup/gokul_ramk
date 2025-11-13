import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  // Singleton instance
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // Stream subscription for authentication events
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;

  GoogleSignInService() {
    _initialize();
  }

  /// Initialize Google Sign-In
  Future<void> _initialize() async {
    await _googleSignIn.initialize(
      clientId: null, // optional for mobile
      serverClientId:
          '805380021313-k6u29vert4tupjoahvfjngsj6fm6v4u5.apps.googleusercontent.com', // optional unless you need backend auth
    );

    // Listen for authentication changes
    _authSubscription = _googleSignIn.authenticationEvents.listen(
      _handleAuthEvent,
      onError: _handleAuthError,
    );

    // Try lightweight authentication (auto sign-in)
    await _googleSignIn.attemptLightweightAuthentication();
  }

  Future<void> _handleAuthEvent(GoogleSignInAuthenticationEvent event) async {
    GoogleSignInAccount? user;
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        user = event.user;
        break;
      case GoogleSignInAuthenticationEventSignOut():
        user = null;
        break;
    }

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes([
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ]);

    _currentUser = user;
    _isAuthorized = authorization != null;
    String? idtoken = user!.authentication.idToken;
    if (kDebugMode) {
      print("================signin with google===================$idtoken  ");
    }

    if (_currentUser != null) {
      EasyLoading.showSuccess("✅ Signed in:(${_currentUser!.email})");
      if (kDebugMode) {
        print(
          "✅ Signed in: ${_currentUser!.displayName} (${_currentUser!.email}) (${_currentUser!.photoUrl} )",
        );
      }
    } else {
      if (kDebugMode) {
        print("🚪 Signed out");
      }
    }
  }

  void _handleAuthError(Object error) {
    if (kDebugMode) {
      EasyLoading.showError("Google Sign-In error");
      print("❌ Google Sign-In error: $error");
    }
    _currentUser = null;
    _isAuthorized = false;
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.authenticate();
    } on GoogleSignInException catch (e) {
      if (kDebugMode) {
        EasyLoading.showError(" Sign-in canceled or failed");
        print("⚠️ Sign-in canceled or failed: ${e.code}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Unknown sign-in error: $e");
      }
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    _currentUser = null;
    _isAuthorized = false;
  }

  /// Current signed-in user
  GoogleSignInAccount? get currentUser => _currentUser;

  /// Whether user is authorized for required scopes
  bool get isAuthorized => _isAuthorized;

  /// Dispose the stream subscription
  void dispose() {
    _authSubscription?.cancel();
  }
}
