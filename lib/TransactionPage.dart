import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(name: 'Name', date: 'Today', time: '08:18 PM', amount: -120),
    // Add other sample transactions
  ];

  TransactionPage({super.key});

  Future<void> saveTransaction(Transaction transaction) async {
    try {
      // Get current user ID
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Store the transaction in Firestore
        FirebaseFirestore.instance.collection('transactions').add({
          'uid': user.uid,
          'name': transaction.name,
          'date': transaction.date,
          'time': transaction.time,
          'amount': transaction.amount,
        });
      }
    } catch (e) {
      print('Error saving transaction: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var transaction = transactions[index];
          return ListTile(
            title: Text(transaction.name),
            subtitle: Text('${transaction.date} - ${transaction.time}'),
            trailing: Text('\$${transaction.amount}'),
            onTap: () => saveTransaction(transaction), // Call save when tapped
          );
        },
      ),
    );
  }
}

class Transaction {
  final String name;
  final String date;
  final String time;
  final double amount;

  Transaction(
      {required this.name,
      required this.date,
      required this.time,
      required this.amount});
}
