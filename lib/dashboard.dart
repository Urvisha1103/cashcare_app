import 'package:cashcare/CalendarPage.dart';
import 'package:cashcare/ExportDataPage.dart';
import 'package:cashcare/TransactionPage.dart';
import 'package:cashcare/account_screen.dart';
import 'package:cashcare/bills.dart';
import 'package:cashcare/currency_converter.dart';
import 'package:cashcare/drawer_menu.dart';
import 'package:cashcare/payment_screen.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'profile_page.dart'; // Import your Profile Page

class DashboardPageWithDrawer extends StatelessWidget {
  const DashboardPageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCCDFF3), // Light blue background color
      appBar: AppBar(
        backgroundColor: Color(0xFF223A6D), // Dark blue app bar color
        title: Text(
          'Dashboard',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
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
        padding: const EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 30.0,
          mainAxisSpacing: 30.0,
          children: [
            _buildDashboardItem(
              icon: Icons.payment,
              label: 'Payment',
              onTap: () {
                // Navigate to Payment
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()),
                );
              },
            ),
            _buildDashboardItem(
              icon: Icons.currency_exchange,
              label: 'Currency',
              onTap: () {
                // Navigate to Currency
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CurrencyConverter()),
                );
              },
            ),
            _buildDashboardItem(
              icon: Icons.receipt_long,
              label: 'Bills',
              onTap: () {
                // Navigate to Bills
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BillsPage()),
                );
              },
            ),
            _buildDashboardItem(
              icon: Icons.account_balance,
              label: 'Accounts',
              onTap: () {
                // Navigate to Accounts
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountScreen()),
                );
              },
            ),
            _buildDashboardItem(
              icon: Icons.swap_horiz,
              label: 'Transactions',
              onTap: () {
                // Navigate to Transactions
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionPage()),
                );
              },
            ),
            _buildDashboardItem(
              icon: Icons.file_upload,
              label: 'Export data',
              onTap: () {
                // Navigate to Export data
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExportDataPage()),
                );
              },
            ),
            _buildDashboardItem(
              icon: Icons.calendar_today,
              label: 'Calendar',
              onTap: () {
                // Navigate to Calendar
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
          ],
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

  // Helper widget to create each dashboard item
  Widget _buildDashboardItem({
    required IconData icon,
    required String label,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.black,
            ),
            SizedBox(height: 10.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
