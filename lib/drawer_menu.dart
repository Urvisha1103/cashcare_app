import 'package:cashcare/dashboard.dart';
import 'package:cashcare/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cashcare/CalendarPage.dart';
import 'package:cashcare/ExportDataPage.dart';
import 'package:cashcare/TransactionPage.dart';
import 'package:cashcare/account_screen.dart';
import 'package:cashcare/bills.dart';
import 'package:cashcare/currency_converter.dart';
import 'package:cashcare/payment_screen.dart';
import 'profile_page.dart'; // Import your Profile Page

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF223A6D), // Dark blue background for the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header with full row clickable (icon + text)
            GestureDetector(
              onTap: () {
                // Navigate to the Profile Page when clicking anywhere on the row
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF223A6D),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 50.0,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Menu items
            _buildDrawerItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
              onTap: () {
                // Navigate to Dashboard
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardPageWithDrawer()),
                );
              },
            ),
            _buildDrawerItem(
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
            _buildDrawerItem(
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
            _buildDrawerItem(
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
            _buildDrawerItem(
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
            _buildDrawerItem(
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
            _buildDrawerItem(
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
            _buildDrawerItem(
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

            Divider(color: Colors.white70),

            // Settings and Logout
            _buildDrawerItem(
              icon: Icons.settings,
              label: 'Setting',
              onTap: () {
                // Navigate to Settings
              },
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () {
                // Logout action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build drawer items
  static Widget _buildDrawerItem({
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
