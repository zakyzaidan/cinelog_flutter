import 'package:cinelog/katalog_screen.dart';
import 'package:cinelog/komunitas_screen.dart';
import 'package:cinelog/home_screen.dart';
import 'package:flutter/material.dart';



class MainScreen extends StatefulWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _curIndex = 0;
  List pages = [
    const HomeScreen(),
    const KatalogScreen(),
    const KomunitasScreen()
  ];

  void onTap(int index){
          setState(() {
            _curIndex = index;
          });
        }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: SafeArea(
          child: pages[_curIndex]
        ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => onTap(index),
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
      ),
    );
  }
}