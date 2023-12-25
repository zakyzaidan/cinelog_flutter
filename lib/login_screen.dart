import 'package:cinelog/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('images/CinelogLogo.png')),
            const SizedBox(height: 80,),
            Container(
              alignment: Alignment.bottomLeft
              ,child: const Text("Username",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              )),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: const Text("Belum memiliki akun? Daftar?"),
                onPressed: (){},
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: const Text("Password",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock)
              )),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: const Text("Lupa Password?"),
                onPressed: (){},
              ),
            ),
            const SizedBox(height: 40,),
            Container(
              height: 50,
              width: double.maxFinite,
              color: const Color(0xFF30475E),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF30475E)
                ),
                
                child: const Text("Login"
                , style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}