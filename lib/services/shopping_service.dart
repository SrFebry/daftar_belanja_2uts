import 'package:firebase_database/firebase_database.dart';

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
              '${value['nama']} \nNPM: ${value['npm']} \nKelas: ${value['kelas']}';
        });
      }
      return items;
    });
  }

  void addShoppingItem(String itemName1, String itemName2, String iteName3) {
    _database
        .push()
        .set({'nama': itemName1, 'npm': itemName2, 'kelas': iteName3});
  }

  Future<void> removeShoppingItem(String key) async {
    await _database.child(key).remove();
  }
}
