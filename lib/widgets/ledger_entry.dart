// lib/widgets/ledger_entry.dart
import 'package:flutter/material.dart';
import 'package:hisabnama_flutter/models/ledger.dart';

class LedgerEntryWidget extends StatelessWidget {
  final LedgerEntry entry;

  const LedgerEntryWidget({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                entry.description,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                entry.debit > 0 ? '₹${entry.debit.toStringAsFixed(2)}' : '',
                style: const TextStyle(fontSize: 14, color: Colors.green),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                entry.credit > 0 ? '₹${entry.credit.toStringAsFixed(2)}' : '',
                style: const TextStyle(fontSize: 14, color: Colors.red),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '₹${entry.balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
