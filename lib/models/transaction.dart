// lib/models/transaction.dart
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 2)
class TransactionEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String debitAccountId;

  @HiveField(4)
  final String creditAccountId;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final int fiscalYear;

  TransactionEntry({
    required this.id,
    required this.description,
    required this.amount,
    required this.debitAccountId,
    required this.creditAccountId,
    required this.date,
    required this.fiscalYear,
  });
}
