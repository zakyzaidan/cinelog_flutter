import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinelog/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_register_event.dart';
part 'login_register_state.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {
  LoginRegisterBloc() : super(LoginRegisterInitial()) {
    on<LoginRegisterInitialEvent>(loginRegisterInitialEvent);
    on<RegisterButtonClickedEvent>(registerClickedEvent);
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LoginRegisterWithGoogleEvent>(loginRegisterWithGoogleEvent);
  }

  FutureOr<void> loginRegisterInitialEvent(
      LoginRegisterInitialEvent event, Emitter<LoginRegisterState> emit) {
    emit(LoginRegisterLoadingState());
    emit(LoginRegisterLoadedSuccessState());
  }

  FutureOr<void> registerClickedEvent(RegisterButtonClickedEvent event,
      Emitter<LoginRegisterState> emit) async {
    emit(LoginRegisterLoadingState());
    final auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'email': event.email, 'username': event.username, 'photo': ''});
      Navigator.of(event.context).pop();
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
        content: Text("Success create account"),
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text("Failed create user = $e"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
    }
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginRegisterState> emit) async {
    emit(LoginRegisterLoadingState());
    final auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      Navigator.pushReplacement(event.context,
          MaterialPageRoute(builder: (context) {
        return MainScreen(
          index: 0,
        );
      }));
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text("Failed login = $e"));
      ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
      emit(LoginRegisterLoadedSuccessState());
    }
  }

  FutureOr<void> loginRegisterWithGoogleEvent(
      LoginRegisterWithGoogleEvent event,
      Emitter<LoginRegisterState> emit) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final _firestore = FirebaseFirestore.instance;
    final _FirebaseAuth = FirebaseAuth.instance;

    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        final GoogleSignInAuthentication googleAuth = await user.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        var result = await _FirebaseAuth.signInWithCredential(credential);
        _firestore.collection('users').doc(result.user!.uid).set({
          'email': result.user!.email,
          'username': result.user!.displayName,
          'photo': result.user!.photoURL
        });
      }

      emit(LoginRegisterWithGoogleSuccessState());
    } catch (e) {
      emit(LoginRegisterWithGoogleErrorState(error: e.toString()));
    }
  }
}
