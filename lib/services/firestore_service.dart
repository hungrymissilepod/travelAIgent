import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:travel_aigent/app/app.locator.dart';
import 'package:travel_aigent/app/app.logger.dart';
import 'package:travel_aigent/models/plan_model.dart';
import 'package:travel_aigent/services/firebase_user_service.dart';
import 'package:travel_aigent/services/who_am_i_service.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseUserService _firebaseUserService =
      locator<FirebaseUserService>();
  final WhoAmIService _whoAmIService = locator<WhoAmIService>();
  final Logger _logger = getLogger('FirestoreService');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference plansCollection =
      FirebaseFirestore.instance.collection('plans');

  final Uuid uuid = const Uuid();

  Future<bool> addUser(String? userId, String name) async {
    _logger.i('name: $name, userId: $userId');

    if (userId == null) {
      _logger.e('userId is null');
      return false;
    }
    _whoAmIService.setName(name);

    List<bool> futures = await Future.wait(<Future<bool>>[
      _addUserToFirestore(userId),
      _addAllPlansToFirestore(userId),
    ], eagerError: true);

    if (futures.any((element) => element == false)) {
      return false;
    }

    return true;
  }

  Future<bool> getUser() async {
    final User? user = _firebaseUserService.user;
    if (user == null) return false;

    DocumentSnapshot userSnapshot = await usersCollection.doc(user.uid).get();
    _logger.i(userSnapshot.data().toString());

    DocumentSnapshot plansSnapshot = await plansCollection.doc(user.uid).get();
    _logger.i(plansSnapshot.data().toString());

    if (userSnapshot.data() == null || plansSnapshot.data() == null) {
      return false;
    }

    final Map<String, dynamic> map = <String, dynamic>{
      'name': userSnapshot.get('name'),
      'plans': plansSnapshot.get('plans'),
    };
    _whoAmIService.setWhoAmI(map);
    return true;
  }

  Future<bool> addPlan(Plan plan) async {
    _logger.i('plan: ${plan.toString()}');
    final User? user = _firebaseUserService.user;
    if (user == null) return false;

    return await _addPlanToFirestore(user.uid, plan);
  }

  Future<bool> _addUserToFirestore(String userId) async {
    bool saved = false;
    await usersCollection
        .doc(userId)
        .set(_whoAmIService.whoAmI.userCollectionJson(userId))
        .then((value) {
      _logger.i('Added user');
      saved = true;
    }).onError((error, stackTrace) {
      _logger.i('Failed to add user: $error');
    });

    return saved;
  }

  Future<bool> _addAllPlansToFirestore(String userId) async {
    bool saved = false;
    await plansCollection
        .doc(userId)
        .set(_whoAmIService.whoAmI.plansCollectionJson(userId))
        .then((value) {
      _logger.i('Added user plans');
      saved = true;
    }).onError((error, stackTrace) {
      _logger.e('Failed to add user plans: $error');
    });

    return saved;
  }

  Future<bool> _addPlanToFirestore(String userId, Plan plan) async {
    bool saved = false;
    await plansCollection.doc(userId).update({
      'plans': FieldValue.arrayUnion([plan.toJson()])
    }).then((value) {
      _logger.i('Added plan data');
      saved = true;
    }).onError((error, stackTrace) {
      _logger.e('Failed to add plan data: $error');
    });

    return saved;
  }
}
