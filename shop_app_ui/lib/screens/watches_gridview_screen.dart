import 'package:flutter/material.dart';
import '../models/watch.dart';

class WatchesGridViewScreen extends StatelessWidget {
  const WatchesGridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Watch> watches = [
      Watch(id: 1, name: 'Rolex Submariner', brand: 'Rolex', price: 8500, type: 'Luxury', isSold: true, soldDate: '2024-01-15', soldTo: 'John Doe'),
      Watch(id: 2, name: 'Apple Watch Series 9', brand: 'Apple', price: 399, type: 'Smart', isSold: false),
      Watch(id: 3, name: 'Omega Seamaster', brand: 'Omega', price: 5200, type: 'Luxury', isSold: true, soldDate: '2024-02-10', soldTo: 'Jane Smith'),
      Watch(id: 4, name: 'Casio G-Shock', brand: 'Casio', price: 150, type: 'Sport', isSold: false),
      Watch(id: 5, name: 'TAG Heuer Carrera', brand: 'TAG Heuer', price: 4300, type: 'Luxury', isSold: false),
      Watch(id: 6, name: 'Samsung Galaxy Watch', brand: 'Samsung', price: 299, type: 'Smart', isSold: true, soldDate: '2024-03-05', soldTo: 'Mike Johnson'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Watches Collection',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: watches.length,
        itemBuilder: (context, index) {
          final watch = watches[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.withOpacity(0.1),
                    Colors.blue.withOpacity(0.1),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Watch Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Text('⌚', style: TextStyle(fontSize: 40)),
                  ),

                  const SizedBox(height: 12),

                  // Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      watch.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Brand
                  Text(
                    watch.brand,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    '\$${watch.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Status Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: watch.isSold ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      watch.isSold ? 'SOLD' : 'AVAILABLE',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}