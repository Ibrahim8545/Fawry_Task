import '../core/interface/is_shippable.dart';
import '../models/cart/cart.dart';
import '../models/customer/customer_sercives.dart';
import '../main.dart';
import 'shipping_service.dart';

class CheckoutService {
  static void processCheckout(Customer customer, Cart cart) {
    if (cart.isEmpty) {
      throw Exception('Cart is empty');
    }

    if (!cart.validateCart()) {
      throw Exception('One or more products are out of stock or expired');
    }

    final double subtotal = cart.subtotal;
    final List<IShippable> shippableItems = cart.shippableItems;
    final double shippingFee = ShippingService.calculateShippingFee(
      shippableItems,
    );
    final double totalAmount = subtotal + shippingFee;

    if (!customer.hasEnoughBalance(totalAmount)) {
      throw Exception("Customer's balance is insufficient");
    }

    if (shippableItems.isNotEmpty) {
      ShippingService.processShipment(shippableItems);
    }

    customer.deductBalance(totalAmount);

    for (final item in cart.items) {
      item.product.reduceQuantity(item.quantity);
    }

    _printReceipt(cart, subtotal, shippingFee, totalAmount, customer.balance);

    cart.clear();
  }

  static void _printReceipt(
    Cart cart,
    double subtotal,
    double shippingFee,
    double totalAmount,
    double remainingBalance,
  ) {
    print('** Checkout receipt **');

    for (final item in cart.items) {
      print(
        '${item.quantity}x ${item.product.name} ${item.totalPrice.toInt()}',
      );
    }

    print('----------------------');
    print('Subtotal ${subtotal.toInt()}');
    print('Shipping ${shippingFee.toInt()}');
    print('Amount ${totalAmount.toInt()}');
    print(
      'Customer balance after payment: \$${remainingBalance.toStringAsFixed(2)}',
    );
    print('END.');
  }
}
