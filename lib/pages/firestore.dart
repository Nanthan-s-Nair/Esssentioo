import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference orders = 
      FirebaseFirestore.instance.collection('orders');

  Future<void> saveOrderToDatabase({
    required String receipt,
    required double amount,
    required String status,
  }) async {
    await orders.add({
      'date': DateTime.now(),
      'order': receipt,
      'amount': amount,
      'status': status,
    });
  }
}
