import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> _generateCSV() async {
    try {
      // Fetch data from Firestore (transactions collection)
      QuerySnapshot snapshot =
          await _firestore.collection('transactions').get();
      List<List<dynamic>> rows = [];

      // Define the headers of your CSV
      rows.add(["Transaction ID", "Amount", "Category", "Date"]);

      // Loop through documents and add data to rows
      for (var doc in snapshot.docs) {
        rows.add([
          doc.id,
          doc['amount'],
          doc['category'],
          doc['date'].toDate().toString(),
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
    } catch (e) {
      print('Error generating CSV: $e');
      return null;
    }
  }

  Future<void> _shareCSV() async {
    String? filePath = await _generateCSV();
    if (filePath != null) {
      final XFile file = XFile(filePath);
      await Share.shareXFiles([file], text: 'Check out my transactions data!');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to generate CSV file")),
      );
    }
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
            backgroundColor: const Color(0xFF223A6D),
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
