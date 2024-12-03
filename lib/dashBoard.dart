
import 'package:biteblitz/src/features/account/views/Account_Screen.dart';
import 'package:biteblitz/src/features/analytics/views/analytics_screen.dart';
import 'package:biteblitz/src/features/menu/views/menu_screen.dart';
import 'package:biteblitz/src/features/orders/views/Orders_screen.dart';
import 'package:biteblitz/src/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class dashboard extends StatefulWidget {

  const dashboard( {super.key});

  /// The navigation shell and container for the branch Navigators.
  // final StatefulNavigationShell navigationShell;


  static const routePath = "/dashboard";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<dashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    orders_screen(),
    menu_screen(),
    analytics_screen(),
    account_screen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false; // Prevent the default back button behavior
    }
    Navigator.pop(context);
    return true; // Allow the default back button behavior
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // body: _screens[_currentIndex],
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Account',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primary_orange_color,
          unselectedItemColor: AppColors.dark_text_color,
          onTap: _onItemTapped,
          elevation: 5,
          type: BottomNavigationBarType.fixed ,
          selectedFontSize: 10,
          unselectedFontSize: 10,
        ),
      ),
    );
  }


  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: widget.navigationShell,
  //       bottomNavigationBar: BottomNavigationBar(
  //               backgroundColor: Colors.white,
  //               items: const <BottomNavigationBarItem>[
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.list_alt_rounded),
  //                   label: 'Orders',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.food_bank),
  //                   label: 'Menu',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.analytics_outlined),
  //                   label: 'Analytics',
  //                 ),
  //                 BottomNavigationBarItem(
  //                   icon: Icon(Icons.person_outlined),
  //                   label: 'Account',
  //                 ),
  //               ],
  //               currentIndex: widget.navigationShell.currentIndex,
  //               selectedItemColor: primary_orange_color,
  //               unselectedItemColor: dark_text_color,
  //               onTap: _onTap,
  //               elevation: 5,
  //               type: BottomNavigationBarType.fixed ,
  //               selectedFontSize: 10,
  //               unselectedFontSize: 10,
  //             ),
  //
  //   );
  // }
  //
  // void _onTap(index) {
  //   widget.navigationShell.goBranch(
  //     index,
  //     // A common pattern when using bottom navigation bars is to support
  //     // navigating to the initial location when tapping the item that is
  //     // already active. This example demonstrates how to support this behavior,
  //     // using the initialLocation parameter of goBranch.
  //     initialLocation: index == widget.navigationShell.currentIndex,
  //   );
  // }

}
