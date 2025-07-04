import '../core/interface/is_shippable.dart';

class ShippingService {
  static const double shippingRatePerKg = 30.0;

  static double calculateShippingFee(List<IShippable> items) {
    double totalWeight = 0.0;
    for (final item in items) {
      totalWeight += item.getWeight();
    }
    return totalWeight * shippingRatePerKg;
  }

  static void processShipment(List<IShippable> items) {
    if (items.isEmpty) return;

    print('** Shipment notice **');
    double totalWeight = 0.0;

    final Map<String, MapEntry<int, double>> itemGroups = {};

    for (final item in items) {
      final String name = item.getName();
      final double weight = item.getWeight();

      if (itemGroups.containsKey(name)) {
        final existing = itemGroups[name]!;
        itemGroups[name] = MapEntry(existing.key + 1, existing.value + weight);
      } else {
        itemGroups[name] = MapEntry(1, weight);
      }
      totalWeight += weight;
    }

    for (final entry in itemGroups.entries) {
      final count = entry.value.key;
      final weight = entry.value.value;
      print('${count}x ${entry.key} ${(weight * 1000).toInt()}g');
    }

    print('Total package weight ${totalWeight.toStringAsFixed(1)}kg');
  }
}
