import 'core/utils/date_time_helper.dart';
import 'models/cart/cart.dart';
import 'models/customer/customer_sercives.dart';
import 'models/product/expirable_shippable_product.dart';
import 'models/product/product.dart';
import 'models/product/shippable_product.dart';
import 'sercivces/checkout_sercices.dart';

void supermarket() {
  print('=== E-COMMERCE SYSTEM DEMONSTRATION ===\n');

  try {
    final cheese = ExpirableShippableProduct(
      name: 'Cheese',
      price: 100.0,
      quantity: 10,
      weight: 0.2,
      expirationDate: createFutureDate(30),
    );

    final tv = ShippableProduct(
      name: 'TV',
      price: 500.0,
      quantity: 5,
      weight: 2.5,
    );

    final scratchCard = Product(
      name: 'Mobile Scratch Card',
      price: 50.0,
      quantity: 20,
    );

    final biscuits = ExpirableShippableProduct(
      name: 'Biscuits',
      price: 150.0,
      quantity: 8,
      weight: 0.7,
      expirationDate: createFutureDate(60),
    );

    final expiredMilk = ExpirableShippableProduct(
      name: 'Expired Milk',
      price: 25.0,
      quantity: 5,
      weight: 0.5,
      expirationDate: createPastDate(5),
    );

    final customer = Customer(name: 'ibrahim', initialBalance: 1000.0);

    final cart = Cart();

    print('1. Testing successful checkout:');
    cart.addItem(cheese, 5);
    cart.addItem(biscuits, 1);
    cart.addItem(scratchCard, 1);

    CheckoutService.processCheckout(customer, cart);

    print('\n2. Testing empty cart error:');
    try {
      CheckoutService.processCheckout(customer, cart);
    } catch (e) {
      print('Error: $e');
    }

    print('\n3. Testing expired product error:');
    try {
      cart.addItem(expiredMilk, 2);
      CheckoutService.processCheckout(customer, cart);
    } catch (e) {
      print('Error: $e');
      cart.clear();
    }

    print('\n4. Testing insufficient balance error:');
    try {
      cart.addItem(tv, 3);
      CheckoutService.processCheckout(customer, cart);
    } catch (e) {
      print('Error: $e');
      cart.clear();
    }

    print('\n5. Testing out of stock error:');
    try {
      cart.addItem(tv, 10);
      CheckoutService.processCheckout(customer, cart);
    } catch (e) {
      print('Error: $e');
      cart.clear();
    }

    print('\n6. Testing non-shippable items only:');
    cart.addItem(scratchCard, 3);
    CheckoutService.processCheckout(customer, cart);

    print('\n7. Testing product information:');
    print('Available products:');
    print('- $cheese (${cheese.type})');
    print('- $tv (${tv.type})');
    print('- $scratchCard (${scratchCard.type})');
    print('- $biscuits (${biscuits.type})');
    print(
      '- $expiredMilk (${expiredMilk.type}) - Expired: ${expiredMilk.isExpired}',
    );

    print('\nCustomer final status: $customer');
  } catch (e) {
    print('System error: $e');
  }
}

void main() {
  supermarket();
}
