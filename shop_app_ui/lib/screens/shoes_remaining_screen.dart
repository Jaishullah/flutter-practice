import 'package:flutter/material.dart';
import '../models/shoe.dart';

class ShoesRemainingScreen extends StatelessWidget {
  const ShoesRemainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Shoe> remainingShoes = [
      Shoe(id: 2, name: 'Adidas Ultraboost', brand: 'Adidas', price: 180, size: 'US 9', isSold: false),
      Shoe(id: 4, name: 'Reebok Classic', brand: 'Reebok', price: 75, size: 'US 10', isSold: false),
      Shoe(id: 5, name: 'New Balance 990', brand: 'New Balance', price: 175, size: 'US 9.5', isSold: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available Shoes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: remainingShoes.length,
        itemBuilder: (context, index) {
          final shoe = remainingShoes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue.shade50,
              ),
              child: Row(
                children: [
                  // Shoe Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Text('👟', style: TextStyle(fontSize: 40)),
                  ),

                  const SizedBox(width: 16),

                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shoe.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${shoe.brand} • Size ${shoe.size}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '\$${shoe.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'IN STOCK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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