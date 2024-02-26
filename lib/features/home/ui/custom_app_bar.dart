import 'package:cinelog/main_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreen(
                              index: 0,
                            ))),
                child: Row(
                  children: [
                    Image.asset(
                      'images/CinelogLogo2.png',
                      scale: 1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "CineLog",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
          customDivider(thickness: 5),
        ],
      ),
    );
  }
}

class customDivider extends StatelessWidget {
  final double? thickness;
  const customDivider({
    super.key,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: thickness,
            color: Color(0xFFFF05454),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: Color(0xFFFF30475E),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: thickness,
            color: Color(0xFFFF222831),
          ),
        ),
      ],
    );
  }
}
