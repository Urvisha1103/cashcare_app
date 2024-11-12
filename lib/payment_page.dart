import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Releases all resources
    super.dispose();
  }

  void openCheckout(double amount) {
    var options = {
      'key': 'YOUR_RAZORPAY_API_KEY', // Replace with your Razorpay key
      'amount': amount * 100, // Razorpay requires the amount in paise
      'name': 'CashCare App',
      'description': 'Payment for your transaction',
      'prefill': {'contact': '1234567890', 'email': 'example@domain.com'},
      'theme': {
        'color':
            '#223A6D' // Dark blue color for consistency with your app theme
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment successful: ${response.paymentId}")),
    );
    Navigator.pop(context); // Navigate back after payment success
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text("Payment failed: ${response.code} - ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet response
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text("External Wallet selected: ${response.walletName}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make a Payment"),
        backgroundColor: const Color(0xFF223A6D),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              openCheckout(500), // Sample amount; replace as needed
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF223A6D),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: const Text("Pay Now"),
        ),
      ),
    );
  }
}
