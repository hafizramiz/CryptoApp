import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cryptocurrency/views/bottom_nav_bar/nav_bar_tabs/exchange_screen.dart';
import 'package:cryptocurrency/views/bottom_nav_bar/nav_bar_tabs/home_screen/my_trending_stream.dart';
import 'package:cryptocurrency/views/bottom_nav_bar/nav_bar_tabs/market_screen/market_screen.dart';
import 'package:cryptocurrency/views/bottom_nav_bar/nav_bar_tabs/wallet_screen/wallet_screen.dart';
import 'package:flutter/material.dart';

import 'nav_bar_tabs/alarm_screen/alarm_screen.dart';
import 'nav_bar_tabs/home_screen/home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget selectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return MarketScreen();
      case 2:
        return WalletScreen();
      case 3:
        return AlarmScreen();
      default:
        return MyTrendingStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.swap_horiz,size: 30,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExchangeScreen(),
              ),
            );
          },
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          activeColor: Colors.red,
          inactiveColor: Colors.black,
          icons: [
            Icons.home,
            Icons.bar_chart,
            Icons.wallet,
            Icons.notification_add
          ],
          gapLocation: GapLocation.center,
          backgroundColor: Colors.yellowAccent,
          splashSpeedInMilliseconds: 300,
          leftCornerRadius: 10,
          rightCornerRadius: 10,
          shadow: BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: Colors.black,
          ),
          activeIndex: _selectedIndex,
          onTap: (int index) {
            _onItemTapped(index);
            print("selected index: ${_selectedIndex}");
          },
        ),
        body: selectedScreen());
  }
}
