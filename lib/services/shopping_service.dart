import 'dart:js';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShoppingService {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('shopping_list');

  Stream<Map<String, String>> getShoppingList() {
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;
      // print('Snapshot data: ${snapshot.value}');
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          // print('Key: $key'); // Print the key
          // print('Value: $value'); // Print the value
          items[key] =
              '\nNama Produk: ${value['nama produk']} \nKode Produk: ${value['kode produk']} \nJumlah: ${value['jumlah']}';
        });
      }
      return items;
    });
  }

  void addShoppingItem(
      String itemName1, String itemName2, String iteName3, context) {
    if (itemName1.isEmpty || itemName2.isEmpty || iteName3.isEmpty) {
      const warning = SnackBar(content: Text('Data Belum Diinput'));
      ScaffoldMessenger.of(context).showSnackBar(warning);
    } else {
      _database.push().set({
        'nama produk': itemName1,
        'kode produk': itemName2,
        'jumlah': iteName3
      });
    }
  }

  Future<void> removeShoppingItem(String key) async {
    await _database.child(key).remove();
  }
}
