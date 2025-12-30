import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news_app/core/constants/firestore_constants.dart';
import 'package:flutter_news_app/data/datasources/remote/firestore_service.dart';
import 'package:flutter_news_app/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import '../../../helper/fakes/fake_user.dart';

void main() {
  late FirebaseFirestore firestore;
  late FirestoreService firestoreService;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    firestoreService = FirestoreService(firestore: firestore);
  });

  test('getUser | user\'a ait döküman olmadıgı durumda null döner', () async {
    final result = await firestoreService.getUser('non_existing_user_id');
    expect(result, isNull);
  });

  test('getUser | user\'a ait döküman varsa UserModel döner', () async {
    final userModel = fakeUser();
    var userJson = userModel.toJson();
    await firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userModel.userId)
        .set(userJson);
    final result = await firestoreService.getUser(userModel.userId);

    expect(result, isNotNull);
    expect(result, isA<UserModel>());
    expect(result!.userId, userModel.userId);
    expect(result.email, userModel.email);
  });
}
