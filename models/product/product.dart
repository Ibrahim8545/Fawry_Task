class Product {
  final String name;
  final double price;
  int quantity;

  Product({required this.name, required this.price, required this.quantity}) {
    if (price < 0) throw ArgumentError('Price cannot be negative');
    if (quantity < 0) throw ArgumentError('Quantity cannot be negative');
  }

  bool get isExpired => false;
  bool get requiresShipping => false;
  double get weight => 0.0;
  String get type => 'Product';

  bool reduceQuantity(int amount) {
    if (amount <= 0) return false;
    if (quantity >= amount) {
      quantity -= amount;
      return true;
    }
    return false;
  }

  bool isAvailable(int requestedQuantity) {
    return !isExpired && quantity >= requestedQuantity;
  }

  @override
  String toString() => '$name - \$${price.toStringAsFixed(2)} (Qty: $quantity)';
}
