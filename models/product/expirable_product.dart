import 'product.dart';

class ExpirableProduct extends Product {
  final DateTime expirationDate;

  ExpirableProduct({
    required super.name,
    required super.price,
    required super.quantity,
    required this.expirationDate,
  });

  @override
  bool get isExpired => DateTime.now().isAfter(expirationDate);

  @override
  String get type => 'ExpirableProduct';
}
