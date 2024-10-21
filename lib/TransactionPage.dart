import 'package:cashcare/drawer_menu.dart';
import 'package:flutter/material.dart';
// Import ProfilePage
// Import BillsPage
// Import CurrencyConverter

class TransactionPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(name: 'Name', date: 'Today', time: '08:18 PM', amount: -120),
    Transaction(name: 'Name', date: 'Today', time: '08:18 PM', amount: 120),
    Transaction(name: 'Name', date: 'Today', time: '12:06 PM', amount: -60),
    Transaction(
        name: 'Name', date: 'Yesterday', time: '12:51 PM', amount: -1000),
    Transaction(name: 'Name', date: '01 Sep', time: '07:43 PM', amount: -100),
    Transaction(name: 'Name', date: '01 Sep', time: '05:13 PM', amount: -500),
    Transaction(name: 'Name', date: '31 Aug', time: '12:14 PM', amount: -1000),
    Transaction(name: 'Name', date: '31 Aug', time: '09:20 PM', amount: 50000),
    Transaction(name: 'Name', date: '30 Aug', time: '03:02 PM', amount: -400),
  ];

  TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCCDFF3),
      appBar: AppBar(
        backgroundColor: Color(0xFF223A6D),
        title: Text('Transaction', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: DrawerMenu(), // Use the reusable drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Paid ${transaction.date}, ${transaction.time}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${transaction.amount >= 0 ? '+' : ''}${transaction.amount}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color:
                            transaction.amount >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper widget to build drawer items
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      onTap: onTap,
    );
  }
}

class Transaction {
  final String name;
  final String date;
  final String time;
  final int amount;

  Transaction({
    required this.name,
    required this.date,
    required this.time,
    required this.amount,
  });
}
