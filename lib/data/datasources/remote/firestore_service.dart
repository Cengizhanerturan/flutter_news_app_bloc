import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news_app/core/constants/firestore_constants.dart';
import 'package:flutter_news_app/data/models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> _addDocumentWithId(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionPath).doc(documentId).set(data);
  }

  Future<void> _updateDocument(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionPath).doc(documentId).update(data);
  }

  // ignore: unused_element
  Future<void> _deleteDocument(String collectionPath, String documentId) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getDocument(
    String collectionPath,
    String documentId,
  ) async {
    return await _firestore.collection(collectionPath).doc(documentId).get();
  }

  Future<bool> _isExistField(
    String collectionPath,
    String checkField,
    String checkValue,
  ) async {
    var querySnapshot =
        await _firestore
            .collection(collectionPath)
            .where(checkField, isEqualTo: checkValue)
            .get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<UserModel?> getUser(String userId) async {
    var documentSnapshot = await _getDocument(
      FirestoreConstants.usersCollection,
      userId,
    );
    if (documentSnapshot.exists) {
      if (documentSnapshot.data() == null) {
        return null;
      }
      return UserModel.fromJson(documentSnapshot.data()!);
    }
    return null;
  }

  Future<void> createUser(UserModel userModel) async {
    var userJson = userModel.toJson();
    await _addDocumentWithId(
      FirestoreConstants.usersCollection,
      userModel.userId,
      userJson,
    );
  }

  Future<void> updateUser(UserModel userModel) async {
    var userId = userModel.userId;
    var userJson = userModel.toJson();
    await _updateDocument(FirestoreConstants.usersCollection, userId, userJson);
  }

  Future<bool> checkEmailExists(String email) async {
    return await _isExistField(
      FirestoreConstants.usersCollection,
      'email',
      email,
    );
  }
}
