import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/services/hive_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';

class FirebaseUserService {
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final HiveService _hiveService = locator<HiveService>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _logger = getLogger('FirebaseUserService');

  FirebaseUserService() {
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

  bool isFullUser() {
    final User? user = _firebaseAuth.currentUser;
    if (user == null || user.isAnonymous) {
      return false;
    }
    return true;
  }

  String? userId() {
    return _firebaseAuth.currentUser?.uid;
  }

  User? get user {
    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      _logger.i('User does not exist');
      return null;
    }

    if (user.isAnonymous) {
      _logger.i('Not full user');
      return null;
    }

    return user;
  }

  bool isUserLoggedIn() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    }
    return true;
  }

  bool isAnonymousUser() {
    if (_firebaseAuth.currentUser?.isAnonymous ?? false) {
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    _logger.i('signing user out');
    await _firebaseAuth.signOut();
    await _hiveService.clear();
    _whoAmIService.reset();
  }

  Future<String?> deleteUser() async {
    _logger.i('deleting user');
    final User? user = _firebaseAuth.currentUser;
    try {
      await user?.delete();
      _whoAmIService.reset();
    } on FirebaseAuthException catch (e) {
      _logger.e('faile to delete user, firebase auth exception: ${e.code}');
      return e.code;
    } catch (e) {
      _logger.e('failed to delete user: ${e.runtimeType}');
      return 'error';
    }
    return null;
  }
}
