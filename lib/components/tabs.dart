import 'package:flutter/material.dart';

class ScrollableContent extends StatelessWidget {
  const ScrollableContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Scrollable Item ${index + 1}'),
            ),
          );
        },
      ),
    );
  }
}