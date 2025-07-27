// lib/services/database_service.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hisabnama_flutter/models/account.dart';
import 'package:hisabnama_flutter/models/transaction.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static const String _accountsBox = 'accounts';
  static const String _transactionsBox = 'transactions';

  late Box<Account> _accounts;
  late Box<TransactionEntry> _transactions;

  Future<void> init() async {
    // Get the application documents directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(documentDirectory.path, 'hisabnama');

    // Initialize Hive with the path
    Hive.init(dbPath);

    // Register adapters if not already registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter<Account>(AccountAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter<AccountType>(AccountTypeAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter<TransactionEntry>(TransactionEntryAdapter());
    }

    // Open boxes with proper typing
    _accounts = await Hive.openBox<Account>(_accountsBox);
    _transactions = await Hive.openBox<TransactionEntry>(_transactionsBox);
  }

  // Account operations
  Future<void> addAccount(Account account) async {
    await _accounts.put(account.id, account);
  }

  Future<void> updateAccount(Account account) async {
    await _accounts.put(account.id, account);
  }

  Future<void> deleteAccount(String id) async {
    await _accounts.delete(id);
  }

  List<Account> getAllAccounts() {
    return _accounts.values.toList();
  }

  Account? getAccount(String id) {
    return _accounts.get(id);
  }

  // Transaction operations
  Future<void> addTransaction(TransactionEntry transaction) async {
    await _transactions.put(transaction.id, transaction);
  }

  Future<void> deleteTransaction(String id) async {
    await _transactions.delete(id);
  }

  List<TransactionEntry> getAllTransactions() {
    return _transactions.values.toList();
  }

  List<TransactionEntry> getTransactionsByYear(int year) {
    return _transactions.values
        .where((transaction) => transaction.fiscalYear == year)
        .toList();
  }

  Future<void> close() async {
    await _accounts.close();
    await _transactions.close();
  }
}
