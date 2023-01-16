import 'package:flutter/material.dart';

class StoreItemListPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _validate(String value) {
    if (value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  void _saveStoreItem() {}

  void _clearTextBoxes() {
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
  }

  Widget _buildStoreItems() {
    return Container();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _nameController,
            validator: (value) => _validate(value!),
            decoration: const InputDecoration(hintText: "Enter store item"),
          ),
          TextFormField(
            controller: _priceController,
            validator: (value) => _validate(value!),
            decoration: const InputDecoration(hintText: "Enter price"),
          ),
          TextFormField(
            controller: _quantityController,
            validator: (value) => _validate(value!),
            decoration: const InputDecoration(hintText: "Enter quantity"),
          ),
          ElevatedButton(
              onPressed: () {},
              child: const Text("Save", style: TextStyle(color: Colors.white))),
          Expanded(child: _buildStoreItems())
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Store name"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )),
        body: _buildBody());
  }
}
