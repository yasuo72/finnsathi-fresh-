import 'package:flutter/material.dart';

class HomeActions {
  static void onProfileTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile tapped! (Navigate to Profile page)')),
    );
    // Navigator.pushNamed(context, '/profile');
  }

  static void onNotificationTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications tapped!')),
    );
  }

  static void onBalanceEyeTap(BuildContext context, VoidCallback toggle) {
    toggle();
  }

  static void onWalletTap(BuildContext context) {
    Navigator.pushNamed(context, '/pin');
  }

  static void onBudgetMoreTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Budget: More tapped!')),
    );
  }

  static void onSavingsTap(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Savings tapped: $title')),
    );
  }

  static void onTransactionTap(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction tapped: $title')),
    );
  }

  static void onTransactionsMoreTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transactions: More tapped!')),
    );
  }

  static void onIncomeTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Income tapped!')),
    );
  }

  static void onOutcomeTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Outcome tapped!')),
    );
  }
}
