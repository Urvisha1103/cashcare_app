import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> _generateCSV() async {
    // Fetch data from Firebase (transactions collection)
    QuerySnapshot snapshot = await _firestore.collection('transactions').get();
    List<List<dynamic>> rows = [];

    // Define the headers of your CSV
    rows.add(["Transaction ID", "Amount", "Category", "Date"]);

    // Loop through documents and add data to rows
    for (var doc in snapshot.docs) {
      rows.add([
        doc.id, // Transaction ID
        doc['amount'], // Amount
        doc['category'], // Category
        doc['date'].toDate().toString(), // Date (converted from timestamp)
      ]);
    }

    // Convert rows to CSV format
    String csvData = const ListToCsvConverter().convert(rows);

    // Get a temporary directory to save the CSV file
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/transactions.csv';

    // Create and write the CSV data to the file
    File file = File(path);
    await file.writeAsString(csvData);

    return path;
  }

  Future<void> _shareCSV() async {
    // Generate the CSV file
    String filePath = await _generateCSV();

    // Share the file using the share package
    Share.shareFiles([filePath], text: 'Check out my transactions data!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share Transaction Data"),
        backgroundColor: const Color(0xFF223A6D),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _shareCSV,
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF223A6D),
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text(
            'Share Transactions',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
