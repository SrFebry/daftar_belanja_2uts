import 'package:daftar_belanja_2uts/screens/out_list_screens.dart';
import 'package:daftar_belanja_2uts/services/shopping_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                MaterialPageRoute(builder: (context) => const ShoppingList()));
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<Map<String, String>>(
              stream: _shoppingService.getShoppingList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, String> items = snapshot.data!;
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final key = items.keys.elementAt(index);
                      final item = items[key];
                      return ListTile(
                        title: Text(item!),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _shoppingService.removeShoppingItem(key);
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ShoppingList()));
              },
              child: const Text("Tambah Data"),
            ),
          ),
        ],
      ),
    );
  }
}
