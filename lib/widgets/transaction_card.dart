// lib/widgets/transaction_card.dart
import 'package:flutter/material.dart';
import 'package:hisabnama_flutter/models/transaction.dart';
import 'package:hisabnama_flutter/services/database_service.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntry transaction;
  final DatabaseService dbService;

  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.dbService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final debitAccount = dbService.getAccount(transaction.debitAccountId);
    final creditAccount = dbService.getAccount(transaction.creditAccountId);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.description,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Debit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      debitAccount?.name ?? 'Unknown',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Credit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      creditAccount?.name ?? 'Unknown',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${transaction.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
