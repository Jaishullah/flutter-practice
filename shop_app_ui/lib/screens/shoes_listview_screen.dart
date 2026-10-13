import 'package:flutter/material.dart';
import '../models/shoe.dart';

class ShoesListViewScreen extends StatelessWidget {
  const ShoesListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Shoe> shoes = [
      Shoe(id: 1, name: 'Nike Air Max 270', brand: 'Nike', price: 150, size: 'US 10', isSold: true, soldDate: '2024-01-20', soldTo: 'Alice Brown'),
      Shoe(id: 2, name: 'Adidas Ultraboost', brand: 'Adidas', price: 180, size: 'US 9', isSold: false),
      Shoe(id: 3, name: 'Puma RS-X', brand: 'Puma', price: 110, size: 'US 11', isSold: true, soldDate: '2024-02-15', soldTo: 'Bob Wilson'),
      Shoe(id: 4, name: 'Reebok Classic', brand: 'Reebok', price: 75, size: 'US 10', isSold: false),
      Shoe(id: 5, name: 'New Balance 990', brand: 'New Balance', price: 175, size: 'US 9.5', isSold: false),
      Shoe(id: 6, name: 'Converse Chuck Taylor', brand: 'Converse', price: 65, size: 'US 10', isSold: true, soldDate: '2024-03-01', soldTo: 'Carol Davis'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shoes Collection',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: shoes.length,
        itemBuilder: (context, index) {
          final shoe = shoes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.withOpacity(0.1),
                    Colors.red.withOpacity(0.1),
                  ],
                ),
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
                          color: Colors.orange.withOpacity(0.3),
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
                                color: shoe.isSold ? Colors.red : Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                shoe.isSold ? 'SOLD' : 'AVAILABLE',
                                style: const TextStyle(
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

                  // Arrow
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade400,
                    size: 18,
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