// lib/models/account.dart
import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final AccountType type;

  @HiveField(3)
  double balance;

  @HiveField(4)
  final DateTime createdAt;

  Account({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    required this.createdAt,
  });
}

@HiveType(typeId: 1)
enum AccountType {
  @HiveField(0)
  Asset,
  @HiveField(1)
  Liability,
  @HiveField(2)
  Income,
  @HiveField(3)
  Expense,
  @HiveField(4)
  Equity,
}
