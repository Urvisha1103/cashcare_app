import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllBillsPage extends StatefulWidget {
  const AllBillsPage({super.key});

  @override
  _AllBillsPageState createState() => _AllBillsPageState();
}

class _AllBillsPageState extends State<AllBillsPage> {
  // ignore: prefer_final_fields
  List<Bill> _bills = [
    Bill(
      id: 1,
      category: 'Electricity',
      issueDate: DateTime(2022, 1, 1),
      dueDate: DateTime(2022, 1, 15),
      amount: 100.0,
    ),
    Bill(
      id: 2,
      category: 'Water',
      issueDate: DateTime(2022, 2, 1),
      dueDate: DateTime(2022, 2, 15),
      amount: 50.0,
    ),
    Bill(
      id: 3,
      category: 'Internet',
      issueDate: DateTime(2022, 3, 1),
      dueDate: DateTime(2022, 3, 15),
      amount: 200.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Bills'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _bills.length,
                itemBuilder: (context, index) {
                  return BillCard(bill: _bills[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bill {
  final int id;
  final String category;
  final DateTime issueDate;
  final DateTime dueDate;
  final double amount;

  Bill({
    required this.id,
    required this.category,
    required this.issueDate,
    required this.dueDate,
    required this.amount,
  });
}

class BillCard extends StatelessWidget {
  final Bill bill;

  const BillCard({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bill #${bill.id}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('Category: ${bill.category}'),
            Text(
                'Issue Date: ${DateFormat('dd MMM yyyy').format(bill.issueDate)}'),
            Text('Due Date: ${DateFormat('dd MMM yyyy').format(bill.dueDate)}'),
            Text('Amount: Rs.${bill.amount}'),
          ],
        ),
      ),
    );
  }
}
