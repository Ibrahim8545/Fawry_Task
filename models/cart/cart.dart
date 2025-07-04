import '../../core/interface/is_shippable.dart';
import '../product/product.dart';
import 'cart_item.dart';

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void addItem(Product product, int quantity) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be positive');
    }

    if (!product.isAvailable(quantity)) {
      throw Exception('Product not available in requested quantity');
    }

    _items.add(CartItem(product: product, quantity: quantity));
  }

  bool get isEmpty => _items.isEmpty;

  double get subtotal {
    double total = 0.0;
    for (final item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  List<IShippable> get shippableItems {
    final List<IShippable> shippableItems = [];

    for (final item in _items) {
      if (item.product.requiresShipping && item.product is IShippable) {
        final shippable = item.product as IShippable;
        for (int i = 0; i < item.quantity; i++) {
          shippableItems.add(shippable);
        }
      }
    }

    return shippableItems;
  }

  void clear() {
    _items.clear();
  }

  bool validateCart() {
    for (final item in _items) {
      if (!item.isValid) {
        return false;
      }
    }
    return true;
  }

  @override
  String toString() {
    if (isEmpty) return 'Cart is empty';
    return 'Cart:\n${_items.map((item) => '  $item').join('\n')}';
  }
}
