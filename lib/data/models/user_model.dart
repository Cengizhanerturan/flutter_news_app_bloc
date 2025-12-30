import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserModel {
  final String userId;
  final String name;
  final String surname;
  final String email;
  final Timestamp createdTime;

  UserModel({
    required this.userId,
    required this.name,
    required this.surname,
    required this.email,
    required this.createdTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      createdTime: json['created_time'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'surname': surname,
      'email': email,
      'created_time': createdTime,
    };
  }

  UserModel copyWith({
    String? userId,
    String? name,
    String? surname,
    String? email,
    dynamic createdTime,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      createdTime: createdTime ?? this.createdTime,
    );
  }

  String get formattedCreatedTime {
    final date = createdTime.toDate();
    return DateFormat('dd.MM.yyyy HH:mm').format(date);
  }
}
