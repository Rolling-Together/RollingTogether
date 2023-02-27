import 'package:flutter/material.dart';
import 'package:rolling_together/ui/screens/my_map_screen.dart';

import '../../ui/screens/community_screen.dart';
import '../../ui/screens/guide_screen.dart';
import '../../ui/screens/12_profile_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;

  final _pages = [
    PageStorage(
      bucket: PageStorageBucket(),
      child: MyMapScreen(),
    ),
    PageStorage(
      bucket: PageStorageBucket(),
      child: CommunityScreen(),
    ),
    PageStorage(
      bucket: PageStorageBucket(),
      child: GuideScreen(),
    ),
    PageStorage(
      bucket: PageStorageBucket(),
      child: ProfileScreen(),
    ),
  ];

  @override
  bool get wantKeepAlive => true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.yellowAccent,
          iconSize: 25.0,
          elevation: 10,
          selectedIconTheme: const IconThemeData(color: Colors.blue),
          selectedItemColor: Colors.blue,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedIconTheme: IconThemeData(color: Colors.grey[600]),
          unselectedItemColor: Colors.grey[600],
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Guide',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ));
  }
}