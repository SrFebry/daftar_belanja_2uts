import 'package:daftar_belanja_2uts/screens/shopping_list_screen.dart';
import 'package:daftar_belanja_2uts/services/shopping_service.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final TextEditingController _controller_1 = TextEditingController();
  final TextEditingController _controller_2 = TextEditingController();
  final TextEditingController _controller_3 = TextEditingController();
  final ShoppingService _shoppingService = ShoppingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Belanja"),
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller_1,
                    decoration: InputDecoration(hintText: 'Nama'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller_2,
                    decoration: InputDecoration(hintText: 'NPM'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller_3,
                    decoration: InputDecoration(hintText: 'Kelas'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _shoppingService.addShoppingItem(
                    _controller_1.text, _controller_2.text, _controller_3.text);
                _controller_1.clear();
                _controller_2.clear();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
              child: const Text("Input Data Baru"),
            ),
          ),
        ],
      ),
    );
  }
}
