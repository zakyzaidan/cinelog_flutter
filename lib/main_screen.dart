import 'package:cinelog/features/catalog/ui/catalog_screen.dart';
import 'package:cinelog/features/comunity/ui/komunitas_screen.dart';
import 'package:cinelog/features/home/ui/home_screen.dart';
import 'package:cinelog/features/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final int index;
  MainScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _curIndex = widget.index;

  List pages = [
    const HomeScreen(),
    KatalogScreen(),
    const KomunitasScreen(),
    ProfileScreen()
  ];

  void onTap(int index) {
    setState(() {
      _curIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[_curIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => onTap(index),
        iconSize: 30,
        selectedFontSize: 23,
        unselectedFontSize: 20,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home, color: Color(0xFFF05454)),
              icon: Icon(
                Icons.home_outlined,
                color: Theme.of(context).primaryColorDark,
              ),
              label: "Home",
              backgroundColor: Color(0xFFE8E8E8)),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.filter, color: Color(0xFFF05454)),
              icon:
                  Icon(Icons.filter, color: Theme.of(context).primaryColorDark),
              label: "Catalog",
              backgroundColor: Color(0xFFE8E8E8)),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.people, color: Color(0xFFF05454)),
              icon: Icon(Icons.people_outline,
                  color: Theme.of(context).primaryColorDark),
              label: "Comunity",
              backgroundColor: Color(0xFFE8E8E8)),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.person, color: Color(0xFFF05454)),
              icon: Icon(Icons.person_2_outlined,
                  color: Theme.of(context).primaryColorDark),
              label: "Profile",
              backgroundColor: Color(0xFFE8E8E8)),
        ],
      ),
    );
  }
}
