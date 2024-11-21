import 'package:esssentioo/pages/payments.dart';
import 'package:flutter/material.dart';


class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  void _proceedToPayment() {
    // Calculate the total amount
    double totalPrice = widget.cartItems.fold<double>(0, (sum, item) {
      double price = item['price'] is String
          ? double.tryParse(item['price'].replaceAll('₹', '').replaceAll(',', '').trim()) ?? 0
          : item['price'];
      return sum + (price * (item['quantity'] ?? 1));
    });

    // Navigate to the PaymentMethodPage with the totalAmount
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodPage(totalAmount: totalPrice),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    double itemPrice = item['price'] is String
        ? double.tryParse(item['price'].replaceAll('₹', '').replaceAll(',', '').trim()) ?? 0
        : item['price'];
    double totalPrice = itemPrice * (item['quantity'] ?? 1);
    return GestureDetector(
      onTap: () {
        // Add your navigation or action logic here if needed
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image for each item
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(item['imagePath'] ?? '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Item details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? 'Unnamed Item',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Quantity: ${item['quantity'] ?? 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle),
                color: Colors.red,
                onPressed: () => _removeItem(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.green,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty", style: TextStyle(color: Colors.black)))
          : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return _buildCartItem(widget.cartItems[index], index);
              },
            ),
      bottomNavigationBar: Container(
        color: Colors.grey[900],
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Expanded(
                  child: Text(
                    '₹${widget.cartItems.fold<double>(0, (sum, item) {
                      double price = item['price'] is String
                          ? double.tryParse(item['price'].replaceAll('₹', '').replaceAll(',', '').trim()) ?? 0
                          : item['price'];
                      return sum + (price * (item['quantity'] ?? 1));
                    }).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 16), 
              child: ElevatedButton(
                onPressed: _proceedToPayment,
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
