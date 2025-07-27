# Hisabnama - Personal Accounting App

A simple, offline desktop accounting application for managing personal or small business finances. No internet required!

## 📋 Features

- **Offline Only**: Works completely without internet
- **Year-wise Books**: Manage finances for different fiscal years
- **Double-entry Bookkeeping**: Professional accounting method
- **Automatic Carry Forward**: Year-end balances automatically transferred
- **Financial Reports**: Generate balance sheets and ledgers
- **Local Storage**: All data stored securely on your computer

## 🖥️ Installation

### Prerequisites

- Windows 10 or later
- No internet connection required after installation

### Installation Steps

1. Download the latest release from [Releases page](https://github.com/kasim1011/hisabnama_flutter/releases/)
2. Extract the ZIP file to your preferred location
3. Double-click `hisabnama.exe` to start the application

## 🚀 Getting Started - Quick Tutorial

Let's set up your first accounting records with sample transactions!

### Step 1: Create Your First Accounts

When you first open **Hisabnama**, you'll see the Accounts screen. Let's create some basic accounts:

1. Click **"New Account"**
2. Create these accounts one by one:

**Bank Account** (Asset)

- Name: `Bank Account`
- Type: `Asset`
- Click **Add**

**Cash in Hand** (Asset)

- Name: `Cash in Hand`
- Type: `Asset`
- Click **Add**

**Salary Income** (Income)

- Name: `Salary Income`
- Type: `Income`
- Click **Add**

**Groceries Expense** (Expense)

- Name: `Groceries Expense`
- Type: `Expense`
- Click **Add**

**Electricity Bill** (Expense)

- Name: `Electricity Bill`
- Type: `Expense`
- Click **Add**

**Business Loan** (Liability)

- Name: `Business Loan`
- Type: `Liability`
- Click **Add**

### Step 2: Record Sample Transactions

Switch to the **Transactions** tab and record these 10 sample transactions:

#### Transaction 1: Salary Received

- Description: `Salary received for January`
- Amount: `50000`
- Debit Account: `Bank Account`
- Credit Account: `Salary Income`
- Date: Today's date
- Click **Record**

#### Transaction 2: Grocery Shopping

- Description: `Weekly grocery shopping`
- Amount: `2500`
- Debit Account: `Groceries Expense`
- Credit Account: `Bank Account`
- Date: Today's date
- Click **Record**

#### Transaction 3: Electricity Payment

- Description: `January electricity bill`
- Amount: `1200`
- Debit Account: `Electricity Bill`
- Credit Account: `Bank Account`
- Date: Today's date
- Click **Record**

#### Transaction 4: Cash Withdrawal

- Description: `ATM withdrawal for daily expenses`
- Amount: `5000`
- Debit Account: `Cash in Hand`
- Credit Account: `Bank Account`
- Date: Today's date
- Click **Record**

#### Transaction 5: Business Loan Taken

- Description: `Loan taken from bank for business`
- Amount: `100000`
- Debit Account: `Bank Account`
- Credit Account: `Business Loan`
- Date: Today's date
- Click **Record**

#### Transaction 6: Office Supplies

- Description: `Purchased office supplies`
- Amount: `800`
- Debit Account: `Groceries Expense`
- Credit Account: `Cash in Hand`
- Date: Today's date
- Click **Record**

#### Transaction 7: Client Payment

- Description: `Payment received from client`
- Amount: `15000`
- Debit Account: `Bank Account`
- Credit Account: `Salary Income`
- Date: Today's date
- Click **Record**

#### Transaction 8: Internet Bill

- Description: `Internet connection bill`
- Amount: `1500`
- Debit Account: `Electricity Bill`
- Credit Account: `Bank Account`
- Date: Today's date
- Click **Record**

#### Transaction 9: Petty Cash

- Description: `Petty cash for office`
- Amount: `2000`
- Debit Account: `Cash in Hand`
- Credit Account: `Bank Account`
- Date: Today's date
- Click **Record**

#### Transaction 10: Transportation

- Description: `Taxi fare for client meeting`
- Amount: `600`
- Debit Account: `Groceries Expense`
- Credit Account: `Cash in Hand`
- Date: Today's date
- Click **Record**

### Step 3: View Your Financial Reports

Switch to the **Reports** tab to see your financial statements:

1. **Balance Sheet**: Shows your financial position
    - Assets: What you own (Bank Account, Cash in Hand)
    - Liabilities: What you owe (Business Loan)
    - Equity: Your net worth

2. **Ledger View**: Click on any account to see its transaction history

## 📚 Accounting Basics Explained

### What is Double-entry Bookkeeping?

Every transaction affects at least two accounts:

- **Debit**: Left side (increases assets/expenses, decreases liabilities/income)
- **Credit**: Right side (decreases assets/expenses, increases liabilities/income)

### Account Types

- **Assets**: What you own (Bank, Cash, Property)
- **Liabilities**: What you owe (Loans, Bills)
- **Income**: Money you earn
- **Expenses**: Money you spend
- **Equity**: Your ownership stake

### Simple Rules

1. **For every debit, there must be a credit**
2. **Total debits must equal total credits**
3. **Assets = Liabilities + Equity**

## 🔧 Troubleshooting

### Common Issues

- **App won't start**: Make sure you have Windows 10 or later
- **Data not saving**: Ensure the app has permission to write to your Documents folder
- **Slow performance**: Close other applications to free up memory

### Data Location

Your data is stored in:

```
C:\Users\[YourUsername]\Documents\hisabnama\
```

## 🛡️ Privacy & Security

- **100% Offline**: No data is sent to any server
- **Local Storage**: All data stays on your computer
- **No Registration**: No need to create accounts or provide personal information

## 🙏 Acknowledgements

This application was developed with the assistance of **Qwen3-Coder**, a large language model by Tongyi Lab. Special
thanks to the Flutter and Dart communities for their excellent documentation and tools.

## 📞 Support

For issues or questions:

1. Check this README first
2. Visit our [GitHub Issues](https://github.com/kasim1011/hisabnama_flutter/issues) page
3. Contact support: [kasim-rangwala@yandex.com]

## 📄 License

MIT License

Copyright (c) 2025 Kasim Rangwala

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

**Happy Accounting with Hisabnama!** 💼📊