import 'package:cinelog/features/login_register/bloc/login_register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginRegisterBloc loginRegisterBloc = LoginRegisterBloc();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
      bloc: loginRegisterBloc,
      listener: (context, state) {},
      builder: (context, state) {
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
                        child: const Text("Create Your Account",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text("Username",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                            hintText: 'Username',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text("Email",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email)),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 20,
                          ),
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
                          child: const Text("Already have account? Login here"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        width: double.maxFinite,
                        color: const Color(0xFF30475E),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF30475E)),
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            loginRegisterBloc.add(RegisterButtonClickedEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                                context: context,
                                username: _usernameController.text));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
