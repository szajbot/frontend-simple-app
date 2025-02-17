import 'package:flutter/material.dart';
import 'package:parking_lot/colors.dart';
import '../containers/dashboard_container.dart';
import '../containers/my_tickets_container.dart';
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
        return CustomColors.background;
      case 1:
        return CustomColors.background;
      case 2:
        return CustomColors.background;
      default:
        return CustomColors.background;
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
            icon: Icon(
              Icons.home,
              color: CustomColors.icon,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apps,
              color: CustomColors.icon,
            ),
            label: 'My Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: CustomColors.icon,
            ),
            label: 'Profile',

          ),
        ],
        selectedItemColor: CustomColors.icon,
        unselectedItemColor: CustomColors.white,
      ),
      body: <Widget>[
        HomeContainer(),
        MyItemsContainer(),
        ProfileContainer(),
      ][currentPageIndex],
    );
  }
}
