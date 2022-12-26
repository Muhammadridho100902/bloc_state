import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:keeper/model/keep_model.dart';

class KeeperRepository {
  Future<void> create(
      {required String username, required String univeristy}) async {
    var userKey = Random();
    var userId = userKey.nextInt(10000);
    final firebaseReal = FirebaseDatabase.instance;
    final reference = firebaseReal.ref().child(
          'keeper/$userId',
        );

    try {
      await reference.set({
        'username': username,
        'univeristy': univeristy,
      });
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(
          "Failed with error ${e.code}, ${e.message}",
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> getList() async {
    final firebaseReal = FirebaseDatabase.instance;
    final reference = firebaseReal.ref();
    final snapshot = await reference.child('keeper').get();
    
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print("No Data available here");
    }
  }
}
