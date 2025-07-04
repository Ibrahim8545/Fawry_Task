import '../../core/interface/is_shippable.dart';
import 'product.dart';

class ShippableProduct extends Product implements IShippable {
  final double _weight;

  ShippableProduct({
    required super.name,
    required super.price,
    required super.quantity,
    required double weight,
  }) : _weight = weight {
    if (weight < 0) throw ArgumentError('Weight cannot be negative');
  }

  @override
  bool get requiresShipping => true;

  @override
  double get weight => _weight;

  @override
  String get type => 'ShippableProduct';

  @override
  String getName() => name;

  @override
  double getWeight() => _weight;
}
