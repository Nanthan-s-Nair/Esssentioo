import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  final String houseAddress;
  final String workAddress;
  final String friendAddress;

  const AddressPage({
    required this.houseAddress,
    required this.workAddress,
    required this.friendAddress,
    super.key,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String _selectedAddress = 'House';

  bool _isEditingHouse = false;
  bool _isEditingWork = false;
  bool _isEditingFriend = false;

  late TextEditingController _houseController;
  late TextEditingController _workController;
  late TextEditingController _friendController;

  @override
  void initState() {
    super.initState();
    _houseController = TextEditingController(text: widget.houseAddress);
    _workController = TextEditingController(text: widget.workAddress);
    _friendController = TextEditingController(text: widget.friendAddress);
  }

  @override
  void dispose() {
    _houseController.dispose();
    _workController.dispose();
    _friendController.dispose();
    super.dispose();
  }

  String _getSelectedAddressText() {
    if (_selectedAddress == 'House') {
      return _houseController.text.isNotEmpty
          ? _houseController.text
          : 'No House Address Provided';
    } else if (_selectedAddress == 'Work') {
      return _workController.text.isNotEmpty
          ? _workController.text
          : 'No Work Address Provided';
    } else {
      return _friendController.text.isNotEmpty
          ? _friendController.text
          : 'No Friend Address Provided';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Address 📍'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // House Section
            RadioListTile<String>(
              title: const Text('House 🏠'),
              value: 'House',
              groupValue: _selectedAddress,
              onChanged: (value) {
                setState(() {
                  _selectedAddress = value!;
                });
              },
            ),
            if (!_isEditingHouse)
              Text(
                _houseController.text.isNotEmpty ? _houseController.text : 'No House Address Provided',
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
            if (_isEditingHouse)
              TextField(
                controller: _houseController,
                decoration: const InputDecoration(
                  labelText: 'Enter your house address',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 10),
            if (!_isEditingHouse)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditingHouse = true;
                  });
                },
                child: const Text('Edit House Address'),
              )
            else
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditingHouse = false;
                  });
                },
                child: const Text('Save House Address'),
              ),

            const SizedBox(height: 16),

            // Work Section
            RadioListTile<String>(
              title: const Text('Work 💼'),
              value: 'Work',
              groupValue: _selectedAddress,
              onChanged: (value) {
                setState(() {
                  _selectedAddress = value!;
                });
              },
            ),
            if (!_isEditingWork)
              Text(
                _workController.text.isNotEmpty ? _workController.text : 'No Work Address Provided',
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            if (_isEditingWork)
              TextField(
                controller: _workController,
                decoration: const InputDecoration(
                  labelText: 'Enter your work address',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 10),
            if (!_isEditingWork)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditingWork = true;
                  });
                },
                child: const Text('Edit Work Address'),
              )
            else
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditingWork = false;
                  });
                },
                child: const Text('Save Work Address'),
              ),

            const SizedBox(height: 16),

            // Friend Section
            RadioListTile<String>(
              title: const Text('Friend 😉'),
              value: 'Friend',
              groupValue: _selectedAddress,
              onChanged: (value) {
                setState(() {
                  _selectedAddress = value!;
                });
              },
            ),
            if (!_isEditingFriend)
              Text(
                _friendController.text.isNotEmpty ? _friendController.text : 'No Friend Address Provided',
                style: const TextStyle(fontSize: 16, color: Colors.orange),
              ),
            if (_isEditingFriend)
              TextField(
                controller: _friendController,
                decoration: const InputDecoration(
                  labelText: 'Enter your friend\'s address',
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 10),
            if (!_isEditingFriend)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditingFriend = true;
                  });
                },
                child: const Text('Edit Friend Address'),
              )
            else
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditingFriend = false;
                  });
                },
                child: const Text('Save Friend Address'),
              ),

            const SizedBox(height: 20),

            // Button to set the selected address as the main address
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _getSelectedAddressText());
              },
              child: const Text('Set Main Address'),
            ),
          ],
        ),
      ),
    );
  }
}