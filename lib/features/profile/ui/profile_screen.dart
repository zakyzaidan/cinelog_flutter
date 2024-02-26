import 'package:cinelog/features/login_register/ui/login_screen.dart';
import 'package:cinelog/features/profile/bloc/profile_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    profileBloc.add(ProfileInitialEvent(auth: _auth, firestore: _firestore));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProfileLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ProfileLoadedSuccessState:
            final successState = state as ProfileLoadedSuccessState;
            final user = successState.user;
            return Scaffold(
                body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text("Username : ${user.username}"),
                          Text("Email    : ${user.email}"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(fontSize: 25),
                          ),
                          _buildList(context),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 70,
                  top: 300 - 70,
                  child: Builder(builder: (context) {
                    if (user.photo.isEmpty) {
                      return CircleAvatar(
                        foregroundColor: Theme.of(context).primaryColor,
                        radius: 70,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      );
                    }
                    return CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(user.photo),
                    );
                  }),
                ),
              ],
            ));

          default:
            return SizedBox();
        }
      },
    );
  }

  _buildList(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Log Out'),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () async {
                try {
                  await _auth.signOut();
                  await _googleSignIn.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                } catch (e) {
                  print("Failed to signout = $e");
                }
                try {
                  await _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                } catch (e) {
                  print("Failed to signout all = $e");
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
