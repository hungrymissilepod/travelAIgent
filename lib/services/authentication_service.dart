import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/firestore_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class AuthenticationService {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _logger = getLogger('AuthenticationService');

  AuthenticationService() {
    init();
  }

  void init() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        _logger.i('authStateChanges - User is currently signed out!');
      } else {
        _logger.i('authStateChanges - User is signed in!');
      }
    });

    _firebaseAuth.idTokenChanges().listen((User? user) {
      if (user == null) {
        _logger.i('idTokenChanges - User is currently signed out!');
      } else {
        _logger.i('idTokenChanges - User is signed in!');
      }
    });

    _firebaseAuth.userChanges().listen((User? user) {
      if (user == null) {
        _logger.i('userChanges - User is currently signed out!');
      } else {
        _logger.i('userChanges - User is signed in!');
      }
    });
  }

  User? get user {
    return _firebaseAuth.currentUser;
  }

  bool userLoggedIn() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    }
    return true;
  }

  Future<String?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      /// Create user
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        /// Save user data to firestore
        await _firestoreService.addUser(userCredential.user?.uid, name);
      } catch (e) {
        /// TODO: check this error message
        return 'Failed to save user data to database';
      }
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

      /// Fetch user data from firestore
      await _firestoreService.getUser();
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
    _whoAmIService.reset();
  }
}
