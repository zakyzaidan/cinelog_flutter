import 'package:cinelog/features/home/ui/custom_app_bar.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const Text(
                "Comunity",
                style: TextStyle(fontSize: 25),
              ),
              const customDivider(thickness: 2),
              Expanded(
                child: Center(
                  child: Text(
                    "Coming Soon",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
