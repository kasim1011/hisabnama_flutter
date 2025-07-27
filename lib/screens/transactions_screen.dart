// lib/screens/transactions_screen.dart
import 'package:flutter/material.dart';
import 'package:hisabnama_flutter/models/account.dart';
import 'package:hisabnama_flutter/models/transaction.dart';
import 'package:hisabnama_flutter/services/accounting_service.dart';
import 'package:hisabnama_flutter/services/database_service.dart';
import 'package:hisabnama_flutter/widgets/transaction_card.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final DatabaseService _dbService = DatabaseService();
  final AccountingService _accountingService = AccountingService(
    DatabaseService(),
  );
  List<TransactionEntry> _transactions = [];
  List<Account> _accounts = [];
  int _currentYear = DateTime.now().year;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  Account? _debitAccount;
  Account? _creditAccount;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _dbService.init();
    setState(() {
      _transactions = _dbService.getTransactionsByYear(_currentYear);
      _accounts = _dbService.getAllAccounts();
    });
  }

  void _showAddTransactionDialog() {
    _descriptionController.clear();
    _amountController.clear();
    _debitAccount = null;
    _creditAccount = null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Record Transaction'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButton<Account>(
                  value: _debitAccount,
                  hint: const Text('Select Debit Account'),
                  isExpanded: true,
                  items: _accounts.map((Account account) {
                    return DropdownMenuItem<Account>(
                      value: account,
                      child: Text(account.name),
                    );
                  }).toList(),
                  onChanged: (Account? newValue) {
                    setState(() {
                      _debitAccount = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButton<Account>(
                  value: _creditAccount,
                  hint: const Text('Select Credit Account'),
                  isExpanded: true,
                  items: _accounts.map((Account account) {
                    return DropdownMenuItem<Account>(
                      value: account,
                      child: Text(account.name),
                    );
                  }).toList(),
                  onChanged: (Account? newValue) {
                    setState(() {
                      _creditAccount = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_descriptionController.text.isNotEmpty &&
                    _amountController.text.isNotEmpty &&
                    _debitAccount != null &&
                    _creditAccount != null) {
                  await _accountingService.recordTransaction(
                    description: _descriptionController.text,
                    amount: double.parse(_amountController.text),
                    debitAccountId: _debitAccount!.id,
                    creditAccountId: _creditAccount!.id,
                    date: DateTime.now(),
                    fiscalYear: _currentYear,
                  );
                  _loadData();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Record'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddTransactionDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('New Transaction'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Fiscal Year:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: _currentYear,
                  items: List.generate(5, (index) => _currentYear - 2 + index)
                      .map(
                        (year) => DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      _currentYear = newValue!;
                      _loadData();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    transaction: _transactions[index],
                    dbService: _dbService,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
