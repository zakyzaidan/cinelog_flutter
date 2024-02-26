import 'package:cinelog/features/login_register/bloc/login_register_bloc.dart';
import 'package:cinelog/features/login_register/ui/register_screen.dart';
import 'package:cinelog/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginRegisterBloc loginRegisterBloc = LoginRegisterBloc();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    loginRegisterBloc.add(LoginRegisterInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
      bloc: loginRegisterBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        if (state is LoginRegisterWithGoogleSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MainScreen(
                      index: 0,
                    );
                  } else {
                    return LoginScreen();
                  }
                });
          }));
        } else if (state is LoginRegisterWithGoogleErrorState) {
          print("error");
          print(state.error);
          ScaffoldMessenger(child: Text(state.error));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoginRegisterLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LoginRegisterLoadedSuccessState:
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: const Image(
                                  image: AssetImage(
                                    'images/CinelogLogo2.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                "CineLog",
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text("Login",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: const Text("Email",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person)),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              child: const Text(
                                  "Don't have an account yet? Register here"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: const Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextField(
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ))),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              child: const Text("Forgot Password?"),
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: double.maxFinite,
                            color: const Color(0xFF30475E),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF30475E)),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                loginRegisterBloc.add(LoginButtonClickedEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    context: context));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "or",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              loginRegisterBloc
                                  .add(LoginRegisterWithGoogleEvent());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Theme.of(context).primaryColorDark),
                              padding: EdgeInsets.all(10),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/googleLogo.png",
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Login with Google",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
