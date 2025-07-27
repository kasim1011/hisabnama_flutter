// lib/widgets/account_card.dart
import 'package:flutter/material.dart';
import 'package:hisabnama_flutter/models/account.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback onTap;

  const AccountCard({Key? key, required this.account, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    IconData iconData;

    switch (account.type) {
      case AccountType.Asset:
        cardColor = Colors.blue.shade100;
        iconData = Icons.account_balance;
        break;
      case AccountType.Liability:
        cardColor = Colors.red.shade100;
        iconData = Icons.credit_card;
        break;
      case AccountType.Income:
        cardColor = Colors.green.shade100;
        iconData = Icons.trending_up;
        break;
      case AccountType.Expense:
        cardColor = Colors.orange.shade100;
        iconData = Icons.shopping_cart;
        break;
      case AccountType.Equity:
        cardColor = Colors.purple.shade100;
        iconData = Icons.account_balance_wallet;
        break;
    }

    return Card(
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(iconData, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    account.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Balance: ₹${account.balance.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                account.type.toString().split('.').last,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
