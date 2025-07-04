class Customer {
  final String name;
  double _balance;

  Customer({required this.name, required double initialBalance})
    : _balance = initialBalance {
    if (initialBalance < 0) throw ArgumentError('Balance cannot be negative');
  }

  double get balance => _balance;

  bool hasEnoughBalance(double amount) => _balance >= amount;

  void deductBalance(double amount) {
    if (amount > _balance) {
      throw Exception('Insufficient balance');
    }
    _balance -= amount;
  }

  @override
  String toString() => '$name (Balance: \$${_balance.toStringAsFixed(2)})';
}
