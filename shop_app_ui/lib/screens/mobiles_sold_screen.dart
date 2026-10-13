import 'package:flutter/material.dart';
import '../models/mobile.dart';

class MobilesSoldScreen extends StatelessWidget {
  const MobilesSoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // All mobiles data
    final List<Mobile> allMobiles = [
      Mobile(
        id: 1,
        name: 'iPhone 15 Pro Max',
        brand: 'Apple',
        price: 1199,
        rating: 4.8,
        storage: '256GB',
        isSold: true,
        soldDate: '2024-01-15',
        soldTo: 'John Smith',
      ),
      Mobile(
        id: 2,
        name: 'Samsung Galaxy S24 Ultra',
        brand: 'Samsung',
        price: 1099,
        rating: 4.7,
        storage: '512GB',
        isSold: true,
      ),
      Mobile(
        id: 3,
        name: 'Google Pixel 8 Pro',
        brand: 'Google',
        price: 899,
        rating: 4.6,
        storage: '128GB',
        isSold: true,
        soldDate: '2024-02-10',
        soldTo: 'Sarah Johnson',
      ),
      Mobile(
        id: 4,
        name: 'OnePlus 12',
        brand: 'OnePlus',
        price: 799,
        rating: 4.5,
        storage: '256GB',
        isSold: false,
      ),
      Mobile(
        id: 5,
        name: 'Xiaomi 14 Pro',
        brand: 'Xiaomi',
        price: 699,
        rating: 4.4,
        storage: '256GB',
        isSold: false,
      ),
      Mobile(
        id: 6,
        name: 'Sony Xperia 1 V',
        brand: 'Sony',
        price: 1299,
        rating: 4.6,
        storage: '512GB',
        isSold: true,
        soldDate: '2024-03-05',
        soldTo: 'Mike Brown',
      ),
    ];

    // Filter to show ONLY sold mobiles
    final soldMobiles = allMobiles.where((mobile) => mobile.isSold).toList();

    return PopScope(
      canPop: false, // Prevents automatic back navigation
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return; // If already popped, do nothing

        // Show confirmation dialog
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Leave Mobiles Sold?'),
            content: const Text('Do you want to go back?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text(
                  'Yes, Go Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );

        // If user confirmed, pop the screen
        if (shouldPop == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: soldMobiles.isEmpty
            ? const Center(
          child: Text(
            'No sold mobiles yet!',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: soldMobiles.length,
          itemBuilder: (context, index) {
            final mobile = soldMobiles[index];
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
                      Colors.blue.withOpacity(0.1),
                      Colors.purple.withOpacity(0.1),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Mobile Icon
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
                      child: const Text(
                        '📱',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mobile.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${mobile.brand} • ${mobile.storage}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (mobile.soldTo != null)
                            Text(
                              'Sold to: ${mobile.soldTo}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              // Price
                              Text(
                                '\$${mobile.price}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Rating
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${mobile.rating}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Status Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
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
      ),
    );
  }
}