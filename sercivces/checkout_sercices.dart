import '../core/interface/is_shippable.dart';
import '../models/cart/cart.dart';
import '../models/customer/customer_sercives.dart';
import '../main.dart';
import 'shipping_service.dart';

class CheckoutService {
  static void processCheckout(Customer customer, Cart cart) {
    // Validate cart is not empty
    if (cart.isEmpty) {
      throw Exception('Cart is empty');
    }

    // Validate all items in cart
    if (!cart.validateCart()) {
      throw Exception('One or more products are out of stock or expired');
    }

    // Calculate totals
    final double subtotal = cart.subtotal;
    final List<IShippable> shippableItems = cart.shippableItems;
    final double shippingFee = ShippingService.calculateShippingFee(
      shippableItems,
    );
    final double totalAmount = subtotal + shippingFee;

    // Check customer balance
    if (!customer.hasEnoughBalance(totalAmount)) {
      throw Exception("Customer's balance is insufficient");
    }

    // Process shipping if applicable
    if (shippableItems.isNotEmpty) {
      ShippingService.processShipment(shippableItems);
    }

    // Process payment
    customer.deductBalance(totalAmount);

    // Reduce product quantities
    for (final item in cart.items) {
      item.product.reduceQuantity(item.quantity);
    }

    // Print checkout receipt
    _printReceipt(cart, subtotal, shippingFee, totalAmount, customer.balance);

    // Clear cart
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
