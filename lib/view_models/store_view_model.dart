
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/store.dart';

class StoreViewModel {

  final Store store; 
  StoreViewModel({required this.store});

  String get storeId {
    return store.storeId;
  }

  String get name {
    return store.name; 
  }

  String get address {
    return store.address; 
  }

  factory StoreViewModel.fromSnapshot(QueryDocumentSnapshot doc) {

    final store = Store.fromSnapshot(doc);
    return StoreViewModel(store: store); 
  }

}