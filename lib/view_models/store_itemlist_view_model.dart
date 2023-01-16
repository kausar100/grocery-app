import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/store_item.dart';
import 'package:grocery_app/utils/constanst.dart';
import 'package:grocery_app/view_models/store_item_view_model.dart';
import 'package:grocery_app/view_models/store_view_model.dart';

class StoreItemListViewModel {
  String name = '';
  double price = 0;
  int quantity = 0;
  final StoreViewModel store;
  String message = '';

  StoreItemListViewModel({required this.store});

  Stream<QuerySnapshot> get storeItemAsStream => FirebaseFirestore.instance
      .collection(Constants.FIRESTORE_COLLECTION)
      .doc(store.storeId)
      .collection(Constants.FIRESTORE_STORE_SUBCOLLECTION)
      .snapshots();

  Future<bool> saveStoreItem() async {
    bool isSaved = false;
    final storeItem = StoreItem(name, price, quantity);
    try {
      await FirebaseFirestore.instance
          .collection(Constants.FIRESTORE_COLLECTION)
          .doc(store.storeId)
          .collection(Constants.FIRESTORE_STORE_SUBCOLLECTION)
          .add(storeItem.toMap());
      isSaved = true;
    } on Exception catch (_) {
      message = "Unable to save the store";
    } catch (error) {
      message = "Error occured!";
    }
    return isSaved;
  }

  void deleteStoreItem(StoreItemViewModel storeItem) {
    FirebaseFirestore.instance
        .collection(Constants.FIRESTORE_COLLECTION)
        .doc(store.storeId)
        .collection(Constants.FIRESTORE_STORE_SUBCOLLECTION)
        .doc(storeItem.storeItemId)
        .delete();
  }
}
