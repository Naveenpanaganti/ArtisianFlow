import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference products = FirebaseFirestore.instance.collection('products');

  // CREATE: Add a new craft item
  Future<void> addProduct(String name, int stock, String artisanId) {
    return products.add({
      'name': name,
      'stock': stock,
      'artisanId': artisanId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // READ: Get products in real-time
  Stream<QuerySnapshot> getProductsStream(String artisanId) {
    return products.where('artisanId', isEqualTo: artisanId).snapshots();
  }
}