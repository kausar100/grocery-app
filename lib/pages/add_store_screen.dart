import 'package:flutter/material.dart';
import 'package:grocery_app/view_models/add_store_view_model.dart';
import 'package:provider/provider.dart';

class AddStorePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  late AddStoreViewModel _addStoreVM;

  void _saveStore(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final isSaved = await _addStoreVM.saveStore();
      if (isSaved) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data Save Successfully")));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _addStoreVM = Provider.of<AddStoreViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: const Text("Add Store")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => _addStoreVM.storeName = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter store name";
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter store name"),
                ),
                TextFormField(
                  onChanged: (value) => _addStoreVM.storeAddress = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter store address";
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter store address"),
                ),
                ElevatedButton(
                  child:
                      const Text("Save", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _saveStore(context);
                  },
                ),
                const Spacer(),
                Text(_addStoreVM.message)
              ],
            ),
          ),
        ));
  }
}
