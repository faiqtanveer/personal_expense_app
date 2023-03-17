class Transaction {
  final int id;
  final double value;
  final String name;
  final DateTime time; //GETS VALUE OF DateTime.Now()

  const Transaction(
      {required this.id,
      required this.value,
      required this.name,
      required this.time});
}
