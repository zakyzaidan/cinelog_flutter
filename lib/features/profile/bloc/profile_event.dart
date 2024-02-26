part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {
  final auth;
  final firestore;

  ProfileInitialEvent({required this.auth, required this.firestore});

  Future<UserModel> getUser() async {
    final snapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: auth.currentUser!.email)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    return userData;
  }
}
