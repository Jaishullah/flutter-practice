
// ====================================================================
// FILE 1: lib/models/mobile.dart
// ACTION: CREATE THIS NEW FILE
// ====================================================================

class Mobile {
  final int id;
  final String name;
  final String brand;
  final double price;
  final double rating;
  final String storage;
  final bool isSold;
  final String? soldDate;
  final String? soldTo;

  Mobile({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.rating,
    required this.storage,
    this.isSold = false,
    this.soldDate,
    this.soldTo,
  });
}