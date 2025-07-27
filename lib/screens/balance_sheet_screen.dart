// lib/screens/balance_sheet_screen.dart
import 'package:flutter/material.dart';
import 'package:hisabnama_flutter/models/account.dart';
import 'package:hisabnama_flutter/models/balance_sheet.dart';
import 'package:hisabnama_flutter/services/accounting_service.dart';
import 'package:hisabnama_flutter/services/database_service.dart';

class BalanceSheetScreen extends StatefulWidget {
  const BalanceSheetScreen({super.key});

  @override
  State<BalanceSheetScreen> createState() => _BalanceSheetScreenState();
}

class _BalanceSheetScreenState extends State<BalanceSheetScreen> {
  final DatabaseService _dbService = DatabaseService();
  final AccountingService _accountingService = AccountingService(
    DatabaseService(),
  );
  List<BalanceSheetItem> _balanceSheetItems = [];
  int _currentYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _loadBalanceSheet();
  }

  Future<void> _loadBalanceSheet() async {
    await _dbService.init();
    setState(() {
      _balanceSheetItems = _accountingService.generateBalanceSheet(
        _currentYear,
      );
    });
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
                  'Balance Sheet',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text('Year:', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: _currentYear,
                      items:
                          List.generate(5, (index) => _currentYear - 2 + index)
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
                          _loadBalanceSheet();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSection('Assets', AccountType.Asset),
                    const SizedBox(height: 20),
                    _buildSection('Liabilities', AccountType.Liability),
                    const SizedBox(height: 20),
                    _buildSection('Equity', AccountType.Equity),
                    const SizedBox(height: 30),
                    _buildTotalSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, AccountType type) {
    final items = _balanceSheetItems
        .where((item) => item.type == type)
        .toList();

    if (items.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...items.map((item) => _buildBalanceSheetRow(item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceSheetRow(BalanceSheetItem item) {
    final isTotal = item.name.startsWith('Total');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '₹${item.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    final totalAssets = _balanceSheetItems
        .where(
          (item) =>
              item.type == AccountType.Asset && item.name.startsWith('Total'),
        )
        .fold(0.0, (sum, item) => sum + item.amount);

    final totalLiabilitiesAndEquity = _balanceSheetItems
        .where(
          (item) =>
              (item.type == AccountType.Liability ||
                  item.type == AccountType.Equity) &&
              item.name.startsWith('Total'),
        )
        .fold(0.0, (sum, item) => sum + item.amount);

    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Total Assets',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '₹${totalAssets.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Total Liabilities & Equity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '₹${totalLiabilitiesAndEquity.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(height: 1, color: Colors.grey),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Difference',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '₹${(totalAssets - totalLiabilitiesAndEquity).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          (totalAssets - totalLiabilitiesAndEquity).abs() < 0.01
                          ? Colors.green
                          : Colors.red,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
