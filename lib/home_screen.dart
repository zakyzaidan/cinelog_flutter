import 'package:flutter/material.dart';
import 'package:cinelog/assets/datafilm.dart';
import 'package:cinelog/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
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
                          Text("User Name"),
                          CircleAvatar(backgroundColor: Colors.grey,),
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 3, color: Colors.black,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text("Exploration", 
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold)
                    ),
                  ),
                  TextField(
                    style: TextStyle(fontSize: 10),
                    decoration: InputDecoration(
                      label: Text("Pencarian"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: BuildCard(),
            )
          ],
        ),
      );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: listfilm.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 330
        ),
      itemBuilder: (context, index){
        return InkWell(
          onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(film: listfilm.elementAt(index));
          }));},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Image.asset(listfilm.elementAt(index).linkcover, 
                height: 250,
                width: double.infinity,
                fit: BoxFit.fill,),
                Divider(thickness: 4,color: Colors.black),
                Row(
                  children: [
                    Text(listfilm.elementAt(index).judul,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Text(listfilm.elementAt(index).tahunRilis+ '  |  '),
                    Text(listfilm.elementAt(index).rating.toString())
                  ],
                ),
              ],
            ),
          ),
        );
  });
  }
}