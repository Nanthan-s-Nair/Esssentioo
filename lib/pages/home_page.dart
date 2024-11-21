import 'package:esssentioo/pages/cart.dart';
import 'package:esssentioo/pages/items.dart';
import 'package:esssentioo/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:esssentioo/components/sidemen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _houseAddress = 'Enter your house address';
  String _workAddress = 'Enter your work address';
  String _friendsAddress = 'Enter your friend\'s address';
  String _selectedAddressType = 'house';
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;
  String _mainAddress = 'No address selected';
  final List<Map<String, dynamic>> _cartItems = [];

  final List<String> _imagePaths = [
    '/Users/nanthansnair/essentio/esssentioo/lib/images/image1.jpeg',
    '/Users/nanthansnair/essentio/esssentioo/lib/images/image2.jpeg',
    '/Users/nanthansnair/essentio/esssentioo/lib/images/image3.jpeg',
    '/Users/nanthansnair/essentio/esssentioo/lib/images/image4.jpeg',
    '/Users/nanthansnair/essentio/esssentioo/lib/images/image5.jpeg',
  ];
  

 final List<Map<String, dynamic>> groceries = [
  {
    "name": "Rice",
    "description": "Premium quality basmati rice.",
    "price": "₹100"
  },
  {
    "name": "Wheat Flour",
    "description": "Fine quality wheat flour for baking.",
    "price": "₹50"
  },
  {
    "name": "Sugar",
    "description": "Granulated sugar for everyday use.",
    "price": "₹40"
  },
  {
    "name": "Salt",
    "description": "Pure salt for cooking.",
    "price": "₹20"
  },
  {
    "name": "Cooking Oil",
    "description": "Refined sunflower oil.",
    "price": "₹150"
  },
  {
    "name": "Pulses",
    "description": "Mixed lentils for nutritious meals.",
    "price": "₹120"
  },
  {
    "name": "Spices",
    "description": "Assorted spices for flavor.",
    "price": "₹80"
  },
  {
    "name": "Tea",
    "description": "Premium tea leaves for brewing.",
    "price": "₹60"
  },
  {
    "name": "Coffee",
    "description": "Rich coffee powder for brewing.",
    "price": "₹200"
  },
  {
    "name": "Vegetables",
    "description": "Fresh seasonal vegetables.",
    "price": "₹70"
  },
];

final List<Map<String, dynamic>> homeEssentials = [
  {
    "name": "Washing Powder",
    "description": "Effective detergent for laundry.",
    "price": "₹250"
  },
  {
    "name": "Dish Soap",
    "description": "Cleans dishes effectively.",
    "price": "₹90"
  },
  {
    "name": "Toilet Cleaner",
    "description": "Strong cleaner for toilet hygiene.",
    "price": "₹150"
  },
  {
    "name": "Surface Cleaner",
    "description": "Multipurpose surface cleaner.",
    "price": "₹100"
  },
  {
    "name": "Air Freshener",
    "description": "Keeps your home smelling fresh.",
    "price": "₹200"
  },
  {
    "name": "Sponge",
    "description": "Soft sponge for cleaning surfaces.",
    "price": "₹50"
  },
  {
    "name": "Trash Bags",
    "description": "Durable trash bags for waste disposal.",
    "price": "₹100"
  },
  {
    "name": "Gloves",
    "description": "Protective gloves for cleaning.",
    "price": "₹120"
  },
  {
    "name": "Mop",
    "description": "Efficient cleaning tool for floors.",
    "price": "₹300"
  },
  {
    "name": "Broom",
    "description": "Sturdy broom for sweeping.",
    "price": "₹70"
  },
];

final List<Map<String, dynamic>> medicines = [
  {
    "name": "Paracetamol",
    "description": "Pain reliever and fever reducer.",
    "price": "₹20"
  },
  {
    "name": "Ibuprofen",
    "description": "Anti-inflammatory pain medication.",
    "price": "₹30"
  },
  {
    "name": "Cetirizine",
    "description": "Allergy relief medication.",
    "price": "₹15"
  },
  {
    "name": "Antacids",
    "description": "Relief from acidity and heartburn.",
    "price": "₹25"
  },
  {
    "name": "Cough Syrup",
    "description": "Soothing syrup for cough relief.",
    "price": "₹50"
  },
  {
    "name": "Vitamins",
    "description": "Essential vitamins for daily health.",
    "price": "₹100"
  },
  {
    "name": "First Aid Kit",
    "description": "Essential supplies for emergencies.",
    "price": "500"
  },
  {
    "name": "Band-Aids",
    "description": "Adhesive bandages for cuts.",
    "price": "₹40"
  },
  {
    "name": "Cold Tablets",
    "description": "Relief from cold symptoms.",
    "price": "₹35"
  },
  {
    "name": "Digestive Enzymes",
    "description": "Aid for digestion.",
    "price": "₹70"
  },
];

final List<Map<String, dynamic>> plasticItems = [
  {
    "name": "Plastic Bottle",
    "description": "Reusable water bottle.",
    "price": "₹150"
  },
  {
    "name": "Storage Container",
    "description": "Durable container for food storage.",
    "price": "₹250"
  },
  {
    "name": "Trash Bin",
    "description": "Sturdy bin for waste disposal.",
    "price": "₹300"
  },
  {
    "name": "Mop Bucket",
    "description": "Bucket for mopping floors.",
    "price": "₹200"
  },
  {
    "name": "Food Storage Bags",
    "description": "Plastic bags for food storage.",
    "price": "₹100"
  },
  {
    "name": "Plastic Cutlery Set",
    "description": "Disposable cutlery for parties.",
    "price": "₹80"
  },
  {
    "name": "Plastic Wrap",
    "description": "Wrap for food preservation.",
    "price": "₹50"
  },
  {
    "name": "Ice Cube Tray",
    "description": "Tray for making ice cubes.",
    "price": "₹60"
  },
  {
    "name": "Plastic Cups",
    "description": "Disposable cups for drinks.",
    "price": "₹70"
  },
  {
    "name": "Plastic Baskets",
    "description": "Baskets for organizing items.",
    "price": "₹120"
  },
];

final List<Map<String, dynamic>> makeupItems = [
  {
    "name": "Foundation",
    "description": "Liquid foundation for a flawless base.",
    "price": "₹400"
  },
  {
    "name": "Lipstick",
    "description": "Long-lasting lip color.",
    "price": "₹250"
  },
  {
    "name": "Mascara",
    "description": "Volumizing mascara for lashes.",
    "price": "₹300"
  },
  {
    "name": "Blush",
    "description": "Powder blush for a healthy glow.",
    "price": "₹200"
  },
  {
    "name": "Eyeliner",
    "description": "Liquid eyeliner for defined eyes.",
    "price": "₹150"
  },
  {
    "name": "Eyeshadow Palette",
    "description": "Variety of colors for eye makeup.",
    "price": "₹800"
  },
  {
    "name": "Makeup Remover",
    "description": "Gentle remover for makeup.",
    "price": "₹250"
  },
  {
    "name": "Nail Polish",
    "description": "Vibrant colors for nails.",
    "price": "₹120"
  },
  {
    "name": "Face Primer",
    "description": "Prepares skin for makeup application.",
    "price": "₹350"
  },
  {
    "name": "Setting Spray",
    "description": "Keeps makeup in place all day.",
    "price": "₹400"
  },
];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _selectDeliveryLocation() async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapPage()),
    );

    if (selectedAddress != null && selectedAddress is String) {
      setState(() {
        _mainAddress = selectedAddress;
      });
    }
  }

  void _updateMainAddress() {
    setState(() {
      if (_selectedAddressType == 'house') {
        _mainAddress = _houseAddress;
      } else if (_selectedAddressType == 'work') {
        _mainAddress = _workAddress;
      } else if (_selectedAddressType == 'friend') {
        _mainAddress = _friendsAddress;
      }
    });
  }

  void _openAddressDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select an Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Enter house address'),
                onChanged: (value) {
                  setState(() {
                    _houseAddress = value;
                  });
                },
              ),
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Enter work address'),
                onChanged: (value) {
                  setState(() {
                    _workAddress = value;
                  });
                },
              ),
              TextField(
                decoration:
                    const InputDecoration(hintText: 'Enter friend\'s address'),
                onChanged: (value) {
                  setState(() {
                    _friendsAddress = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              RadioListTile<String>(
                title: const Text('House'),
                value: 'house',
                groupValue: _selectedAddressType,
                onChanged: (value) {
                  setState(() {
                    _selectedAddressType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Work'),
                value: 'work',
                groupValue: _selectedAddressType,
                onChanged: (value) {
                  setState(() {
                    _selectedAddressType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Friend\'s Address'),
                value: 'friend',
                groupValue: _selectedAddressType,
                onChanged: (value) {
                  setState(() {
                    _selectedAddressType = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _updateMainAddress();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _navigateToItemPage(Map<String, dynamic> item, String category) {
  // Define the imagePath based on item name and category
  String imagePath;

  if (category == 'groceries') {
    switch (item['name']) {
      case 'Rice':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png';
        break;
      case 'Wheat Flour':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/atta.png';
        break;
      case 'Sugar':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/sugar.png';
        break;
      case 'Salt':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/salt.png';
        break;
      case 'Cooking Oil':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/oil.webp';
        break;
      case 'Pulses':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/pulses.png';
        break;
      case 'Spices':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/spices.webp';
        break;
      case 'Tea':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/tea.png';
        break;
      case 'Coffee':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/coffee.png';
        break;
      case 'Vegetables':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/vegetables.png';
        break;
      default:
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png'; // Default image
    }
  } else if (category == 'homeEssentials') {
    switch (item['name']) {
      case 'Air Freshener':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/airfreshner.png';
        break;
      case 'Broom':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/broom.png';
        break;
      case 'Dish Soap':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/dishsoap.png';
        break;
      case 'Toilet Cleaner':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/toiletcleaner.png';
        break;
      case 'Surface Cleaner':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/floorcleaner.png';
        break;
      case 'Gloves':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/gloves.png';
        break;
      case 'Mop':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/mop.png';
        break;
      case 'Sponge':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/sponge.png';
        break;
      case 'Trash Bags':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/trashbag.png';
        break;
      case 'Washing Powder':
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/washingpowder.png';
        break;
      default:
        imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png'; // Default image
    }
  } else {
    // Default images for other categories
    if (category == 'medicines') {
      imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/medicine.png';
    } else if (category == 'plasticItems') {
      imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/plastic.png';
    } else if (category == 'makeupItems') {
      imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/makeup.png';
    } else {
      imagePath = '/path/to/default_image.png'; // Fallback for any other categories
    }
  }

  // Create a new item map including the imagePath
  Map<String, dynamic> itemWithImage = {
    ...item,
    'imagePath': imagePath,
  };

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ItemsPage(
        item: itemWithImage,
        onAddToCart: _addToCart,
      ),
    ),
  );
}


 Widget _buildFoodList(List<Map<String, dynamic>> foodItems, String category) {
  return ListView.builder(
    itemCount: foodItems.length,
    itemBuilder: (context, index) {
      final item = foodItems[index];
      String imagePath;

      // Assign specific images for each category
      if (category == 'groceries') {
        switch (item['name']) {
          case 'Rice':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png';
            break;
          case 'Wheat Flour':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/atta.png';
            break;
          case 'Sugar':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/sugar.png';
            break;
          case 'Salt':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/salt.png';
            break;
          case 'Cooking Oil':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/oil.webp';
            break;
          case 'Pulses':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/pulses.png';
            break;
          case 'Spices':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/spices.webp';
            break;
          case 'Tea':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/tea.png';
            break;
          case 'Coffee':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/coffee.png';
            break;
          case 'Vegetables':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/groceries/vegetables.png';
            break;
          default:
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png';
        }
      } else if (category == 'homeEssentials') {
        switch (item['name']) {
          case 'Air Freshener':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/airfreshner.png';
            break;
          case 'Broom':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/broom.png';
            break;
          case 'Dish Soap':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/dishsoap.png';
            break;
          case 'Toilet Cleaner':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/toiletcleaner.png';
            break;
          case 'Surface Cleaner':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/floorcleaner.png';
            break;
          case 'Gloves':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/gloves.png';
            break;
          case 'Mop':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/mop.png';
            break;
          case 'Sponge':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/sponge.png';
            break;
          case 'Trash Bags':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/trashbag.png';
            break;
          case 'Washing Powder':
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/homeneeds/washingpowder.png';
            break;
          default:
            imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/rice.png';
        }
      } else {
        // Default images for other categories
        if (category == 'medicines') {
          imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/medicine.png';
        } else if (category == 'plasticItems') {
          imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/plastic.png';
        } else if (category == 'makeupItems') {
          imagePath = '/Users/nanthansnair/essentio/esssentioo/lib/images/makeup.png';
        } else {
          imagePath = '/path/to/default_image.png'; // Fallback for any other categories
        }
      }

      return GestureDetector(
        onTap: () {
          _navigateToItemPage(item,category);
        },
        child: Card(
          color: Colors.grey[800],
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the specific image for each item
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
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
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['description'] ?? 'No description available',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['price'] ?? 'Price not available',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _addToCart(Map<String, dynamic> item) {
    setState(() {
      _cartItems.add(item);
    });
  }

  void _navigateToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: _cartItems),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final Color borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    final Color backgroundColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : const Color(0xFF91B969);
    final Color backgroundColor2 =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : const Color.fromARGB(255, 237, 232, 87);

    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: backgroundColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.location_on),
              iconSize: 30,
              onPressed: _openAddressDialog,
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              iconSize: 30,
              onPressed: _navigateToCartPage,
            ),
            IconButton(
              icon: const Icon(Icons.map), // Map icon
              iconSize: 30,
              onPressed: _selectDeliveryLocation,
            ),
          ],
        ),
        drawer: const MyDrawer(),
        backgroundColor: backgroundColor2,
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _imagePaths.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        _imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Deliver to 📍: $_mainAddress',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TabBar(
  labelColor: Colors.black,
  unselectedLabelColor: Colors.black54,
  isScrollable: true,
  labelStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold), 
  unselectedLabelStyle: const TextStyle(fontSize: 16),
  tabs: [
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: const Tab(text: 'Groceries'),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: const Tab(text: 'Home Needs'), 
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: const Tab(text: 'Medicines'),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: const Tab(text: 'Essentials'),
    ),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: const Tab(text: 'Makeup'),
    ),
  ],
),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFoodList(groceries,'groceries'),
                  _buildFoodList(homeEssentials,'homeEssentials'),
                  _buildFoodList(medicines,'medicines'),
                  _buildFoodList(plasticItems,'plasticItems'),
                  _buildFoodList(makeupItems,'makeupItems'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
