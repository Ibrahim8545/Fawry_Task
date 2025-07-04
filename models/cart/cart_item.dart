import '../product/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  double get totalPrice => product.price * quantity;

  bool get isValid => product.isAvailable(quantity);

  @override
  String toString() =>
      '${quantity}x ${product.name} \$${totalPrice.toStringAsFixed(2)}';
}
