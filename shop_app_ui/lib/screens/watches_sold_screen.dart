import 'package:flutter/material.dart';
import '../models/watch.dart';

class WatchesSoldScreen extends StatelessWidget {
  const WatchesSoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Watch> soldWatches = [
      Watch(id: 1, name: 'Rolex Submariner', brand: 'Rolex', price: 8500, type: 'Luxury', isSold: true, soldDate: '2024-01-15', soldTo: 'John Doe'),
      Watch(id: 3, name: 'Omega Seamaster', brand: 'Omega', price: 5200, type: 'Luxury', isSold: true, soldDate: '2024-02-10', soldTo: 'Jane Smith'),
      Watch(id: 6, name: 'Samsung Galaxy Watch', brand: 'Samsung', price: 299, type: 'Smart', isSold: true, soldDate: '2024-03-05', soldTo: 'Mike Johnson'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sold Watches',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: soldWatches.length,
        itemBuilder: (context, index) {
          final watch = soldWatches[index];
          return Card(
            elevation: 4,
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
                  // Icon and Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('⌚', style: TextStyle(fontSize: 30)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'SOLD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Name
                  Text(
                    watch.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

                  const Spacer(),

                  const Divider(),

                  // Sale Info
                  _buildInfoText('💰 \$${watch.price}'),
                  const SizedBox(height: 4),
                  _buildInfoText('📅 ${watch.soldDate}'),
                  const SizedBox(height: 4),
                  _buildInfoText('👤 ${watch.soldTo}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 11),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}