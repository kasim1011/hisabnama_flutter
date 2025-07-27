// lib/models/balance_sheet.dart
import 'package:hisabnama_flutter/models/account.dart';

class BalanceSheetItem {
  final String name;
  final double amount;
  final AccountType type;

  BalanceSheetItem({
    required this.name,
    required this.amount,
    required this.type,
  });
}
