class Transaction {
  final String from;
  final String to;
  final double value;
  final DateTime date;

  Transaction({
    required this.from,
    required this.to,
    required this.value,
    required this.date,
  });
}
