import 'dart:io';
import 'package:cashcare/drawer_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportDataPage extends StatefulWidget {
  const ExportDataPage({super.key});

  @override
  _ExportDataPageState createState() => _ExportDataPageState();
}

class _ExportDataPageState extends State<ExportDataPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  Future<void> _exportData() async {
    setState(() {
      _isLoading = true;
    });

    // Fetch data from Firestore
    final QuerySnapshot snapshot = await _firestore
        .collection('transactions')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(_startDate))
        .where('date', isLessThanOrEqualTo: Timestamp.fromDate(_endDate))
        .orderBy('date', descending: true)
        .get();

    final List<String> csvData = [
      'Date,Type,Description,Amount',
      ...snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final date = (data['date'] as Timestamp).toDate();
        final type = data['type'] ?? '';
        final description = data['description'] ?? '';
        final amount = data['amount'] ?? 0;
        return '${_formatDate(date)},$type,$description,$amount';
      }),
    ];

    // Generate the CSV file
    final String csvContent = csvData.join('\n');
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File(
        '${directory.path}/transactions_${_formatDate(_startDate)}_${_formatDate(_endDate)}.csv');
    await file.writeAsString(csvContent);

    setState(() {
      _isLoading = false;
    });

    // Share the CSV file using share_plus
    await Share.shareXFiles([XFile(file.path)],
        text: 'Transactions data export');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Data'),
        backgroundColor: const Color(0xFF0C2551),
      ),
      drawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Select Date Range',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Start Date'),
                    subtitle: Text(_formatDate(_startDate)),
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('End Date'),
                    subtitle: Text(_formatDate(_endDate)),
                    onTap: () => _selectDate(context, false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _exportData,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C2551),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: const Size.fromHeight(50),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Export Data',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
