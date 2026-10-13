class Shoe {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String size;
  final bool isSold;
  final String soldDate;
  final String soldTo;
  final String image;

  Shoe({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.size,
    required this.isSold,
    this.soldDate = '',
    this.soldTo = '',
    this.image = '👟',
  });
}