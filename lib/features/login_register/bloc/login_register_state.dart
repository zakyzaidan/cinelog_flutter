part of 'login_register_bloc.dart';

@immutable
sealed class LoginRegisterState {}

abstract class RegisterActionState extends LoginRegisterState {}

abstract class LoginActionState extends LoginRegisterState {}

final class LoginRegisterInitial extends LoginRegisterState {}

final class LoginRegisterLoadedSuccessState extends LoginRegisterState {}

final class LoginRegisterLoadingState extends LoginRegisterState {}

final class RegisterButtonClickedState extends RegisterActionState {}

final class LoginButtonClickedState extends LoginActionState {}

final class LoginRegisterWithGoogleSuccessState extends LoginActionState {}

final class LoginRegisterWithGoogleErrorState extends LoginActionState {
  final String error;

  LoginRegisterWithGoogleErrorState({required this.error});
}
