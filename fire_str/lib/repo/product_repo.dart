import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductRepo {
  // final _firestore = FirebaseFirestore.instance.collection('products');

  Future<void> create({required String name, required String price}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference _products = firestore.collection('products');
    try {
      await _products.add({'name': name, 'price': price});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed With error ${e.code}, ${e.message}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
