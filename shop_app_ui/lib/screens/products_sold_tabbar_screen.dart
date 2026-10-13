import 'package:flutter/material.dart';
import 'shoes_sold_screen.dart';
import 'mobiles_sold_screen.dart';

class ProductsSoldTabBarScreen extends StatelessWidget {
  const ProductsSoldTabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Products Sold',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,

          // TabBar at bottom of AppBar
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 6,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                icon: Icon(Icons.shopping_bag),
                text: 'Shoes Sold',
              ),
              Tab(
                icon: Icon(Icons.phone_android),
                text: 'Mobiles Sold',
              ),
            ],
          ),
        ),

        // TabBarView - Shows content for each tab
        body: const TabBarView(
          children: [
            ShoesSoldScreen(),   // Tab 1 content (separate file!)
            MobilesSoldScreen(), // Tab 2 content (separate file!)
          ],
        ),
      ),
    );
  }
}
