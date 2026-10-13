import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/watches_gridview_screen.dart';
import 'screens/shoes_listview_screen.dart';
import 'screens/shoes_sold_screen.dart';
import 'screens/shoes_remaining_screen.dart';
import 'screens/watches_sold_screen.dart';
import 'screens/watches_remaining_screen.dart';
import 'screens/products_sold_tabbar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Store',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/watches-grid': (context) => const WatchesGridViewScreen(),
        '/shoes-list': (context) => const ShoesListViewScreen(),
        '/shoes-sold': (context) => const ProductsSoldTabBarScreen(),
        '/shoes-remaining': (context) => const ShoesRemainingScreen(),
        '/watches-sold': (context) => const WatchesSoldScreen(),
        '/watches-remaining': (context) => const WatchesRemainingScreen(),

      },
    );
  }
}