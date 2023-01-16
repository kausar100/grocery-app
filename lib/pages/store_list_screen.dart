import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/pages/add_store_screen.dart';
import 'package:grocery_app/utils/constanst.dart';
import 'package:grocery_app/view_models/add_store_view_model.dart';
import 'package:grocery_app/view_models/store_list_view_model.dart';
import 'package:grocery_app/view_models/store_view_model.dart';
import 'package:grocery_app/widgets/empty_results_widget.dart';
import 'package:provider/provider.dart';

class StoreListPage extends StatefulWidget {
  @override
  _StoreListPage createState() => _StoreListPage();
}

class _StoreListPage extends State<StoreListPage> {
  final StoreListViewModel _storeListVM = StoreListViewModel();

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: _storeListVM.storesAsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return _buildList(snapshot.data!);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return EmptyResultsWidget(message: Constants.NO_STORES_FOUND);
          }
        });
  }

  Widget _buildList(QuerySnapshot snapshot) {
    final stores =
        snapshot.docs.map((doc) => StoreViewModel.fromSnapshot(doc)).toList();
    return ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return _buildListItem(store);
        });
  }

  Widget _buildListItem(StoreViewModel store) {
    return ListTile(
      title: Text(store.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      subtitle: Text(store.address),
    );
  }

  void _navigateToAddStorePage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => AddStoreViewModel(),
                child: AddStorePage()),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Grocery App"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: const Icon(Icons.add),
                onTap: () {
                  _navigateToAddStorePage(context);
                },
              ),
            )
          ],
        ),
        body: _buildBody());
  }
}
