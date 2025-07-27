// lib/screens/accounts_screen.dart
import 'package:flutter/material.dart';
import 'package:hisabnama_flutter/models/account.dart';
import 'package:hisabnama_flutter/services/accounting_service.dart';
import 'package:hisabnama_flutter/services/database_service.dart';
import 'package:hisabnama_flutter/widgets/account_card.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  // Use the singleton instance
  final DatabaseService _dbService = DatabaseService();
  late AccountingService _accountingService;
  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    _accountingService = AccountingService(_dbService);
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    // No need to init() since it's already done in main.dart
    setState(() {
      _accounts = _dbService.getAllAccounts();
    });
  }

  void _showAddAccountDialog() {
    final TextEditingController nameController = TextEditingController();
    AccountType selectedType = AccountType.Asset;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Account Name'),
              ),
              const SizedBox(height: 16),
              DropdownButton<AccountType>(
                value: selectedType,
                items: AccountType.values.map((AccountType type) {
                  return DropdownMenuItem<AccountType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (AccountType? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedType = newValue;
                    });
                  }
                },
              ),
            ],
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
                if (nameController.text.isNotEmpty) {
                  await _accountingService.createAccount(
                    nameController.text,
                    selectedType,
                  );
                  _loadAccounts();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
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
                  'Chart of Accounts',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _showAddAccountDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('New Account'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _accounts.length,
                itemBuilder: (context, index) {
                  return AccountCard(
                    account: _accounts[index],
                    onTap: () {
                      // Navigate to ledger screen
                    },
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
