import 'package:flutter/material.dart';
import 'package:cinelog/assets/datafilm.dart';

class KatalogScreen extends StatelessWidget {
  const KatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Column(
        children: [
          Text("data",style: TextStyle(color: Colors.amber),),
          Flexible(
            child: GridView.count(
                        crossAxisCount: 2,
                        children: listfilm.map((film){
                          return Container(
                            height: 100,
                            width: 100,
                            color: Colors.amber,
                          );
                        }).toList(),
                      )
          )],
      )
    );
  }
}