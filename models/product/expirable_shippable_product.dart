import '../../core/interface/is_shippable.dart';
import 'expirable_product.dart';

class ExpirableShippableProduct extends ExpirableProduct implements IShippable {
  final double _weight;

  ExpirableShippableProduct({
    required super.name,
    required super.price,
    required super.quantity,
    required double weight,
    required super.expirationDate,
  }) : _weight = weight {
    if (weight < 0) throw ArgumentError('Weight cannot be negative');
  }

  @override
  bool get requiresShipping => true;

  @override
  double get weight => _weight;

  @override
  String get type => 'ExpirableShippableProduct';

  @override
  String getName() => name;

  @override
  double getWeight() => _weight;
}
