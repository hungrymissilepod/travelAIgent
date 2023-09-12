import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/firestore_service.dart';

class AuthenticationService {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _logger = getLogger('AuthenticationService');

  Future<void> createAnonymousUser() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      _logger.i('Created an anonymous account');

      /// Save user data to firestore
      try {
        await _firestoreService.addUser(FirebaseAuth.instance.currentUser?.uid, 'Anonymous');
      } catch (e) {
        _logger.e('Failed to save Anonymous user to Firestore - UserId: ${FirebaseAuth.instance.currentUser?.uid}');
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          _logger.e("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          _logger.e("Unknown error.");
      }
    }
  }

  Future<String?> linkUserWithEmailCredential(String name, String email, String password) async {
    final AuthCredential? credential = await _getEmailCredential(email, password);

    if (credential == null) {
      return 'failed-get-email-credential';
    }

    final UserCredential? userCredential;

    /// Link anonymous user to their email
    try {
      userCredential = await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      _logger.e(e.code);
      return e.code;
    } catch (e) {
      _logger.e(e.runtimeType);
      return 'generic-error';
    }

    if (userCredential == null) {
      return 'no-user-credential';
    }

    /// Update user's name
    try {
      await _firestoreService.updateUserName(FirebaseAuth.instance.currentUser?.uid, name);
    } catch (e) {
      return 'failed-to-save-user-data';
    }

    return null;
  }

  Future<AuthCredential?> _getEmailCredential(String email, String password) async {
    try {
      final AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      return credential;
    } catch (e) {
      _logger.e('_getEmailCredential: ${e.runtimeType}');
    }
    return null;
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
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

  Future<String?> reauthenticateWithCredential(String email, String password) async {
    try {
      final AuthCredential? credential = await _getEmailCredential(email, password);
      await _firebaseAuth.currentUser?.reauthenticateWithCredential(credential!);
    } on FirebaseAuthException catch (e) {
      _logger.e(e.code);
      return e.code;
    } catch (e) {
      _logger.e(e.runtimeType);
      return 'generic-error';
    }
    return null;
  }
}
