import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news_app/data/models/user_model.dart';

UserModel fakeUser() {
  return UserModel(
    userId: '1',
    name: 'Cengizhan',
    surname: 'Erturan',
    email: 'cengizhanerturan@gmail.com',
    createdTime: Timestamp.now(),
  );
}
