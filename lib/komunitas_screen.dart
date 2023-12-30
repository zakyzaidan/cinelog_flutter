import 'package:flutter/material.dart';

class KomunitasScreen extends StatelessWidget {
  const KomunitasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('images/CinelogLogo.png',scale: 2,),
                        const Row(
                          children: [
                            Icon(Icons.notifications),
                            SizedBox(width: 5),
                            Text("User Name"),
                            SizedBox(width: 5),
                            CircleAvatar(backgroundColor: Colors.grey,),
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 3, color: Colors.black,
                    ),
                  ],
                ),
              ), const Center(child: Text("Komunitas Screen",style: TextStyle(fontSize: 40),))
            ],
          ),
        ),
      ),
    );
  }
}