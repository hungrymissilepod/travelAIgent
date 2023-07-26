import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.logger.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _logger = getLogger('AuthenticationService');

  AuthenticationService() {
    init();
  }

  void init() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('authStateChanges - User is currently signed out!');
      } else {
        print('authStateChanges - User is signed in!');
      }
    });

    _firebaseAuth.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('idTokenChanges - User is currently signed out!');
      } else {
        print('idTokenChanges - User is signed in!');
      }
    });

    _firebaseAuth.userChanges().listen((User? user) {
      if (user == null) {
        print('userChanges - User is currently signed out!');
      } else {
        print('userChanges - User is signed in!');
      }
    });
  }

  bool userLoggedIn() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    }
    return true;
  }

  Future<String?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _logger.e(e.code);
      return e.code;
    } catch (e) {
      _logger.e(e.runtimeType);
      return 'generic-error';
    }
    return null;
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _logger.e(e.code);
      return e.code;
    } catch (e) {
      _logger.e(e.runtimeType);
      return 'generic-error';
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
