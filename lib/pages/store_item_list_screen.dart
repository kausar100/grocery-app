import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/utils/constanst.dart';
import 'package:grocery_app/view_models/store_item_view_model.dart';
import 'package:grocery_app/view_models/store_itemlist_view_model.dart';
import 'package:grocery_app/view_models/store_view_model.dart';
import 'package:grocery_app/widgets/store_items_widget.dart';

class StoreItemListPage extends StatelessWidget {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late StoreItemListViewModel _storeItemListViewModel;

  String? _validate(String value) {
    if (value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  void _saveStoreItem(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _storeItemListViewModel.name = _nameController.text;
      _storeItemListViewModel.price = double.parse(_priceController.text);
      _storeItemListViewModel.quantity = int.parse(_quantityController.text);

      //save the store item
      bool save = await _storeItemListViewModel.saveStoreItem();
      if (save) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Store item save successfully!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_storeItemListViewModel.message)));
      }
      _clearTextBoxes();
    }
  }

  void _clearTextBoxes() {
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
  }

  Widget _buildStoreItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: _storeItemListViewModel.storeItemAsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          final storeItems = snapshot.data!.docs
              .map((item) => StoreItemViewModel.fromSnapshot(item))
              .toList();
          return StoreItemsWidget(
            storeItems: storeItems,
            onStoreItemDeleted: (storeItem) {
              _storeItemListViewModel.deleteStoreItem(storeItem);
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return const Center(child: Text(Constants.NO_STORES_FOUND));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = ModalRoute.of(context)!.settings.arguments as StoreViewModel;
    _storeItemListViewModel = StoreItemListViewModel(store: store);
    return Scaffold(
        appBar: AppBar(
            title: Text(store.name),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )),
        body: Padding(
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
                  onPressed: () {
                    _saveStoreItem(context);
                  },
                  child: const Text("Save",
                      style: TextStyle(color: Colors.white))),
              Expanded(child: _buildStoreItems())
            ]),
          ),
        ));
  }
}
