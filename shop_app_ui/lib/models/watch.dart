class Watch {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String type;
  final bool isSold;
  final String soldDate;
  final String soldTo;
  final String image;

  Watch({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.type,
    required this.isSold,
    this.soldDate = '',
    this.soldTo = '',
    this.image = '⌚',
  });
}