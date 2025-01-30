import 'package:flutter/material.dart';
import '../containers/home_container.dart';
import '../containers/my_items_container.dart';
import '../containers/profile_container.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  getColorForContainer() {
    switch (currentPageIndex) {
      case 0:
        return Color.fromARGB(255, 190, 170, 170);
      case 1:
        return Color.fromARGB(255, 190, 170, 170);
      case 2:
        return Color.fromARGB(255, 190, 170, 170);
      default:
        return Color.fromARGB(255, 190, 170, 170);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: getColorForContainer(),
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'My Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
      ),
      body: <Widget>[
        HomeContainer(),
        MyItemsContainer(),
        ProfileContainer(),
      ][currentPageIndex],
    );
  }
}
