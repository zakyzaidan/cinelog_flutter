part of 'login_register_bloc.dart';

@immutable
sealed class LoginRegisterEvent {}

final class LoginRegisterInitialEvent extends LoginRegisterEvent {}

final class RegisterButtonClickedEvent extends LoginRegisterEvent {
  final String email;
  final String password;
  final String username;
  final BuildContext context;

  RegisterButtonClickedEvent(
      {required this.email,
      required this.password,
      required this.context,
      required this.username});
}

final class LoginButtonClickedEvent extends LoginRegisterEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginButtonClickedEvent(
      {required this.email, required this.password, required this.context});
}

final class LoginRegisterWithGoogleEvent extends LoginRegisterEvent {}
