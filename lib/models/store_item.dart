import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  final String? _storeItemId;
  final String name;
  final double price;
  final int quantity;

  String? get storeItemId => _storeItemId;

  StoreItem(this.name, this.price, this.quantity, [this._storeItemId]);

  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'quantity': quantity};
  }

  factory StoreItem.fromSnapshot(QueryDocumentSnapshot doc) {
    return StoreItem(doc["name"], doc["price"], doc['quantity'], doc.id);
  }
}
