import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  final double totalAmount;

  const PaymentMethodPage({super.key, required this.totalAmount});

  @override
  // ignore: library_private_types_in_public_api
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPaymentOption('Amazon Pay', '/Users/nanthansnair/essentio/esssentioo/lib/images/amazon-pay.png', () {
              setState(() => selectedMethod = 'Amazon Pay');
              navigateToEmailInput(context, 'Amazon Pay');
            }),
            buildPaymentOption('Credit Card', '/Users/nanthansnair/essentio/esssentioo/lib/images/visa.png', () {
              setState(() => selectedMethod = 'Credit Card');
              navigateToCardDetailsInput(context);
            }),
            buildPaymentOption('Paypal', '/Users/nanthansnair/essentio/esssentioo/lib/images/paypal.png', () {
              setState(() => selectedMethod = 'Paypal');
              navigateToEmailInput(context, 'Paypal');
            }),
            buildPaymentOption('Google Pay', '/Users/nanthansnair/essentio/esssentioo/lib/images/google-pay.png', () {
              setState(() => selectedMethod = 'Google Pay');
              navigateToEmailInput(context, 'Google Pay');
            }),
            const Spacer(),
            Center(
              child: Text(
                'Total Payment: ₹${widget.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
              padding: const EdgeInsets.only(bottom: 16), 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoadingScreen(totalAmount: widget.totalAmount),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(12),
                ),
                child: const Text(
                  "Confirm Payment",
                  style: TextStyle(color: Colors.black), 
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOption(String method, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selectedMethod == method ? Colors.blue.shade100 : Colors.white,
          border: Border.all(
            color: selectedMethod == method ? Colors.blue : Colors.black87,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              method,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: selectedMethod == method ? Colors.blue : Colors.black,
              ),
            ),
            const Spacer(),
            Image.asset(imagePath, height: 80), 
          ],
        ),
      ),
    );
  }

  void navigateToCardDetailsInput(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CardDetailsPage()),
    );
  }

  void navigateToEmailInput(BuildContext context, String method) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailInputPage(paymentMethod: method)),
    );
  }
}

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Card Details'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Credit Card Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.credit_card),
              ),
              keyboardType: TextInputType.number,
              maxLength: 16,
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiration Date',
                      hintText: 'MM/YY',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: 'XXX',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    maxLength: 3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name on Card',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            Center(
              child: Padding(
              padding: const EdgeInsets.only(bottom: 16), 
              child: ElevatedButton(
               onPressed: () {
                Navigator.pop(context);
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(12),
                ),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(color: Colors.black), 
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInputPage extends StatelessWidget {
  final String paymentMethod;

  const EmailInputPage({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter $paymentMethod Email'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Email ID'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 16), 
              child: ElevatedButton(
               onPressed: () {
                Navigator.pop(context); 
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(12),
                ),
                child: const Text(
                  "Proceed to Payment",
                  style: TextStyle(color: Colors.black), 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final double totalAmount;

  const LoadingScreen({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => PaymentSuccessPage(totalAmount: totalAmount)),
      );
    });

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Processing Payment...'),
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessPage extends StatefulWidget {
  final double totalAmount;

  const PaymentSuccessPage({super.key, required this.totalAmount});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  late String transactionId;
  late DateTime transactionDate;
  final String deliveryPartnerPhone = '+9123454534'; 

  @override
  void initState() {
    super.initState();
    transactionId = _generateTransactionId();
    transactionDate = DateTime.now();
    savePaymentReceiptToFirestore();
  }

  Future<void> savePaymentReceiptToFirestore() async {
    await FirebaseFirestore.instance.collection('payments').add({
      'amount': widget.totalAmount,
      'date': transactionDate,
      'status': 'success',
      'transactionId': transactionId,
    });
  }

  String _generateTransactionId() {
    return 'TXN${DateTime.now().millisecondsSinceEpoch}'; 
  }

  @override
  Widget build(BuildContext context) {
    const int estimatedDeliveryMinutes = 45; 
    DateTime estimatedDeliveryTime =
        transactionDate.add(const Duration(minutes: estimatedDeliveryMinutes));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Successful'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Payment Successful!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text('Transaction ID: $transactionId'),
            Text('Date: ${transactionDate.toLocal()}'),
            Text('Estimated Delivery Time: ${estimatedDeliveryTime.toLocal()}'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone, color: Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Call Delivery Partner',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Phone: $deliveryPartnerPhone',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Display a dialog to simulate call action
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Call Delivery Partner'),
                          content: Text(
                              'Calling delivery partner at $deliveryPartnerPhone...'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Call',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(12),
                ),
                child: const Text(
                  "Go to Home",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}