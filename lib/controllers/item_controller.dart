import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class ItemController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getItems(bool isLibrary) {
  final collection = isLibrary ? 'components' : 'catalog';

  return _firestore.collection(collection).snapshots().map((snapshot) {
    print(" Fetched ${snapshot.docs.length} items from '$collection'");
    
    for (var doc in snapshot.docs) {
      print("Document: ${doc.id} → ${doc.data()}");
    }

    return snapshot.docs.map((doc) => {
      'id': doc.id,
      'item': Item(
        name: doc['name'] ?? '',
        description: doc['description'] ?? '',
      ),
    }).toList();
  });
}

  Future<void> addItem(bool isLibrary, Item item) {
    final collection = isLibrary ? 'components' : 'catalog';
    return _firestore.collection(collection).add({
      'componentName': item.name,
      'description': item.description,
    });
  }

  Future<void> updateItem(bool isLibrary, String docId, Item item) {
    final collection = isLibrary ? 'components' : 'catalog';
    return _firestore.collection(collection).doc(docId).update({
      'componentName': item.name,
      'description': item.description,
    });
  }

  Future<void> deleteItem(bool isLibrary, String docId) {
    final collection = isLibrary ? 'components' : 'catalog';
    return _firestore.collection(collection).doc(docId).delete();
  }
}
