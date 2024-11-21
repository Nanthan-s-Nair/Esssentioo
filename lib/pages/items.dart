import 'package:flutter/material.dart';

class ItemsPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddToCart;
  final Map<String, dynamic> item;

  const ItemsPage({super.key, required this.onAddToCart, required this.item});

  @override
  // ignore: library_private_types_in_public_api
  _ItemsPageState createState() => _ItemsPageState();
}
class _ItemsPageState extends State<ItemsPage> {
  int quantity = 1;
  String selectedQuantityUnit = '';

  @override
  Widget build(BuildContext context) {
    List<String> quantityOptions;
    String itemName = widget.item['name']?.toLowerCase() ?? '';
    List<String> groceryItems = ['rice', 'wheat flour', 'sugar', 'salt', 'cooking oil', 'oil'];
    List<String> medicineItems = ['paracetamol', 'ibuprofen', 'cetirizine', 'antacids', 'cough syrup'];
    List<String> makeupItems = ['foundation', 'lipstick', 'mascara', 'blush', 'eyeliner'];

    // Determine quantity options based on item type
    if (groceryItems.contains(itemName)) {
      quantityOptions = ['Half kg', '1 kg', '2 kg'];
    } else if (medicineItems.contains(itemName)) {
      quantityOptions = ['250 mg', '500 mg', '1 g'];
    } else if (makeupItems.contains(itemName)) {
      quantityOptions = ['Small', 'Medium', 'Large'];
    } else {
      quantityOptions = ['Piece', 'Pack', 'Bundle'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['name'] ?? 'Unknown Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ensure that the correct imagePath is being used
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.item['imagePath'] ?? 
                      '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png'
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.item['name'] ?? 'Unnamed Item',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.item['description'] ?? 'No description available',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Price: ${widget.item['price'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey[700], thickness: 1.5),
              const SizedBox(height: 16),
              const Text(
                'Select Quantity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: quantityOptions.map((option) {
                  return ChoiceChip(
                    label: Text(option),
                    selected: selectedQuantityUnit == option,
                    onSelected: (selected) {
                      setState(() {
                        selectedQuantityUnit = selected ? option : '';
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final itemToAdd = {
                      'name': widget.item['name'],
                      'description': widget.item['description'],
                      'price': widget.item['price'],
                      'imagePath': widget.item['imagePath'], // Ensure this is correct
                      'quantity': quantity,
                      'selectedUnit': selectedQuantityUnit,
                    };

                    widget.onAddToCart(itemToAdd);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${widget.item['name']} added to cart! Quantity: $quantity')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
