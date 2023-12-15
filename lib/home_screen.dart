import 'package:flutter/material.dart';
import 'package:cinelog/assets/datafilm.dart';
//import 'package:cinelog/detail_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _curIndex = 1;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 70, 20, 70),
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
                const SizedBox(
                  height: 10,
                ),
               
                
              ],
            ),
          ),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              children: listfilm.map((film){
                return Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(film.linkcover)
                );
              }).toList(),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedFontSize: 23,
        unselectedFontSize: 20,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: Color(0xFFF05454)),
            icon: Icon(Icons.home_outlined,color: Colors.black,),
            label: "home",
            backgroundColor:  Color(0xFFE8E8E8)
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.filter, color: Color(0xFFF05454)),
            icon: Icon(Icons.filter,color: Colors.black),
            label: "Katalog",
            backgroundColor:  Color(0xFFE8E8E8)
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.people, color: Color(0xFFF05454)),
            icon: Icon(Icons.people_outline,color: Colors.black),
            label: "Komunitas",
            backgroundColor:  Color(0xFFE8E8E8)
          ),
        ],
        onTap: (index){
          setState(() {
            _curIndex = index;
          });
        },
      ),
    );
  }
}