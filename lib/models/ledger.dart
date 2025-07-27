// lib/models/ledger.dart
class LedgerEntry {
  final String accountId;
  final String description;
  final double debit;
  final double credit;
  final DateTime date;
  final double balance;

  LedgerEntry({
    required this.accountId,
    required this.description,
    required this.debit,
    required this.credit,
    required this.date,
    required this.balance,
  });
}
