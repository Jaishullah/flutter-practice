import 'package:flutter/material.dart';
import '../models/shoe.dart';

class ShoesSoldScreen extends StatelessWidget {
  const ShoesSoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Shoe> soldShoes = [
      Shoe(id: 1, name: 'Nike Air Max 270', brand: 'Nike', price: 150, size: 'US 10', isSold: true, soldDate: '2024-01-20', soldTo: 'Alice Brown'),
      Shoe(id: 3, name: 'Puma RS-X', brand: 'Puma', price: 110, size: 'US 11', isSold: true, soldDate: '2024-02-15', soldTo: 'Bob Wilson'),
      Shoe(id: 6, name: 'Converse Chuck Taylor', brand: 'Converse', price: 65, size: 'US 10', isSold: true, soldDate: '2024-03-01', soldTo: 'Carol Davis'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sold Shoes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: soldShoes.length,
        itemBuilder: (context, index) {
          final shoe = soldShoes[index];
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
                color: Colors.green.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('👟', style: TextStyle(fontSize: 35)),
                      ),
                      const SizedBox(width: 16),
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
                            Text(
                              shoe.brand,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'SOLD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 24),

                  // Sale Info
                  _buildInfoRow(Icons.attach_money, 'Price', '\$${shoe.price}'),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.calendar_today, 'Sold Date', shoe.soldDate),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.person, 'Sold To', shoe.soldTo),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.straighten, 'Size', shoe.size),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}