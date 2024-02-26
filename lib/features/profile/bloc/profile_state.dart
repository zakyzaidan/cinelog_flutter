part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedSuccessState extends ProfileState {
  final UserModel user;

  ProfileLoadedSuccessState({required this.user});
}
