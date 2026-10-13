import 'package:flutter/material.dart';
import 'main_tab_screen.dart';
import 'shoes_tab_screen.dart';
import 'watches_tab_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MainTabScreen(),
    const ShoesTabScreen(),
    const WatchesTabScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ❌ REMOVE: drawer: const AppDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shoes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Watches',
          ),
        ],
      ),
    );
  }
}