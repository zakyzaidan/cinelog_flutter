import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String photo;

  UserModel({required this.email, required this.photo, required this.username});

  factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        email: data['email'], photo: data['photo'], username: data['username']);
  }

  Map<String, Object?> toJson() =>
      {'email': email, 'photo': photo, 'username': username};
}
