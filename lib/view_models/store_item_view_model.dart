import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/store_item.dart';
import 'package:grocery_app/view_models/store_view_model.dart';

class StoreItemViewModel {
  final StoreItem storeItem;

  StoreItemViewModel({required this.storeItem});

  String get name => storeItem.name;

  String? get storeItemId => storeItem.storeItemId;

  double get price => storeItem.price;

  int get quantity => storeItem.quantity;

  factory StoreItemViewModel.fromSnapshot(QueryDocumentSnapshot doc) {
    final storeItem = StoreItem.fromSnapshot(doc);
    return StoreItemViewModel(storeItem: storeItem);
  }
}
