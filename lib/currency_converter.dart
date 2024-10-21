import 'package:cashcare/CalendarPage.dart';
import 'package:cashcare/ExportDataPage.dart';
import 'package:cashcare/TransactionPage.dart';
import 'package:cashcare/account_screen.dart';
import 'package:cashcare/bills.dart';
import 'package:cashcare/dashboard.dart';
import 'package:cashcare/profile_page.dart';
import 'package:cashcare/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String fromCurrency = 'USD';
  String toCurrency = 'INR';
  double exchangeRate = 0.0;
  TextEditingController amountController = TextEditingController();
  double convertedAmount = 0.0;

  List<String> currencies = ['USD', 'EUR', 'GBP', 'INR'];

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  Future<void> fetchExchangeRate() async {
    final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        exchangeRate = data['rates'][toCurrency];
      });
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  void convertCurrency() {
    double amount = double.parse(amountController.text);
    setState(() {
      convertedAmount = amount * exchangeRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCCDFF3),
      appBar: AppBar(
        backgroundColor: Color(0xFF223A6D),
        title: const Text('Currency Converter',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open drawer action
              },
            );
          },
        ),
      ),
      drawer: CustomDrawer(), // Use CustomDrawer class
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/currency.png', width: 250.0),
              SizedBox(height: 20.0),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: fromCurrency,
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        fromCurrency = value!;
                        fetchExchangeRate();
                      });
                    },
                  ),
                  SizedBox(width: 20.0),
                  DropdownButton<String>(
                    value: toCurrency,
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        toCurrency = value!;
                        fetchExchangeRate();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Rate: ${exchangeRate.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF223A6D),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: convertCurrency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF223A6D),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Convert',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                convertedAmount.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF223A6D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Drawer
  Widget CustomDrawer() {
    return Drawer(
      child: Container(
        color: Color(0xFF223A6D), // Dark blue background for the drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
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
            _buildDrawerItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
              onTap: () {
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
                Navigator.pop(context); // Close the drawer
              },
            ),
            _buildDrawerItem(
              icon: Icons.receipt_long,
              label: 'Bills',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BillsPage()), // Create BillsPage
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.account_balance,
              label: 'Accounts',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AccountScreen()), // Create AccountsPage
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.swap_horiz,
              label: 'Transactions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TransactionPage()), // Create TransactionsPage
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.file_upload,
              label: 'Export data',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ExportDataPage()), // Create ExportDataPage
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.calendar_today,
              label: 'Calendar',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CalendarPage()), // Create CalendarPage
                );
              },
            ),
            Divider(color: Colors.white70),
            _buildDrawerItem(
              icon: Icons.settings,
              label: 'Setting',
              onTap: () {
                // Implement navigation to SettingsPage if you have one
              },
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () {
                // Implement logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }

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
