// lib/services/accounting_service.dart
import 'package:hisabnama_flutter/models/account.dart';
import 'package:hisabnama_flutter/models/balance_sheet.dart';
import 'package:hisabnama_flutter/models/ledger.dart';
import 'package:hisabnama_flutter/models/transaction.dart';
import 'package:hisabnama_flutter/services/database_service.dart';
import 'package:uuid/uuid.dart';

class AccountingService {
  final DatabaseService _dbService;

  AccountingService(this._dbService);

  // Create a new account
  Future<void> createAccount(String name, AccountType type) async {
    final account = Account(
      id: const Uuid().v4(),
      name: name,
      type: type,
      balance: 0.0,
      createdAt: DateTime.now(),
    );
    await _dbService.addAccount(account);
  }

  // Record a transaction
  Future<void> recordTransaction({
    required String description,
    required double amount,
    required String debitAccountId,
    required String creditAccountId,
    required DateTime date,
    required int fiscalYear,
  }) async {
    final transaction = TransactionEntry(
      id: const Uuid().v4(),
      description: description,
      amount: amount,
      debitAccountId: debitAccountId,
      creditAccountId: creditAccountId,
      date: date,
      fiscalYear: fiscalYear,
    );

    await _dbService.addTransaction(transaction);

    // Update account balances
    final debitAccount = _dbService.getAccount(debitAccountId);
    final creditAccount = _dbService.getAccount(creditAccountId);

    // Add null safety
    if (debitAccount != null && creditAccount != null) {
      debitAccount.balance += amount;
      creditAccount.balance -= amount;

      await _dbService.updateAccount(debitAccount);
      await _dbService.updateAccount(creditAccount);
    }
  }

  // Get ledger entries for an account
  List<LedgerEntry> getLedgerEntries(String accountId) {
    final transactions = _dbService.getAllTransactions();
    final account = _dbService.getAccount(accountId);

    if (account == null) return [];

    double balance = 0.0;
    final entries = <LedgerEntry>[];

    // Sort transactions by date
    transactions.sort((a, b) => a.date.compareTo(b.date));

    for (var transaction in transactions) {
      if (transaction.debitAccountId == accountId) {
        balance += transaction.amount;
        entries.add(
          LedgerEntry(
            accountId: accountId,
            description: transaction.description,
            debit: transaction.amount,
            credit: 0.0,
            date: transaction.date,
            balance: balance,
          ),
        );
      } else if (transaction.creditAccountId == accountId) {
        balance -= transaction.amount;
        entries.add(
          LedgerEntry(
            accountId: accountId,
            description: transaction.description,
            debit: 0.0,
            credit: transaction.amount,
            date: transaction.date,
            balance: balance,
          ),
        );
      }
    }

    return entries;
  }

  // Generate balance sheet
  List<BalanceSheetItem> generateBalanceSheet(int fiscalYear) {
    final accounts = _dbService.getAllAccounts();
    final assets = <BalanceSheetItem>[];
    final liabilities = <BalanceSheetItem>[];
    final equity = <BalanceSheetItem>[];

    double totalAssets = 0.0;
    double totalLiabilities = 0.0;
    double totalEquity = 0.0;

    for (var account in accounts) {
      switch (account.type) {
        case AccountType.Asset:
          assets.add(
            BalanceSheetItem(
              name: account.name,
              amount: account.balance,
              type: AccountType.Asset,
            ),
          );
          totalAssets += account.balance;
          break;
        case AccountType.Liability:
          liabilities.add(
            BalanceSheetItem(
              name: account.name,
              amount: account.balance.abs(),
              type: AccountType.Liability,
            ),
          );
          totalLiabilities += account.balance.abs();
          break;
        case AccountType.Equity:
          equity.add(
            BalanceSheetItem(
              name: account.name,
              amount: account.balance.abs(),
              type: AccountType.Equity,
            ),
          );
          totalEquity += account.balance.abs();
          break;
        case AccountType.Income:
        case AccountType.Expense:
          // Income and Expense accounts typically don't appear on balance sheet directly
          // but their net effect impacts equity
          break;
      }
    }

    // Add totals
    assets.add(
      BalanceSheetItem(
        name: 'Total Assets',
        amount: totalAssets,
        type: AccountType.Asset,
      ),
    );

    liabilities.add(
      BalanceSheetItem(
        name: 'Total Liabilities',
        amount: totalLiabilities,
        type: AccountType.Liability,
      ),
    );

    equity.add(
      BalanceSheetItem(
        name: 'Total Equity',
        amount: totalEquity,
        type: AccountType.Equity,
      ),
    );

    return [...assets, ...liabilities, ...equity];
  }

  // Carry forward balances to next year
  Future<void> carryForwardBalances(int fromYear, int toYear) async {
    final accounts = _dbService.getAllAccounts();

    for (var account in accounts) {
      // Create new account for next year with opening balance
      final newAccount = Account(
        id: '${account.id}_$toYear',
        name: account.name,
        type: account.type,
        balance: account.balance,
        createdAt: DateTime.now(),
      );

      await _dbService.addAccount(newAccount);
    }
  }
}
