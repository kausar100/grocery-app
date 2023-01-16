

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/utils/constanst.dart';

class StoreListViewModel {

  Stream<QuerySnapshot> get storesAsStream {
    return FirebaseFirestore.instance.collection(Constants.FIRESTORE_COLLECTION).snapshots();
  }

}