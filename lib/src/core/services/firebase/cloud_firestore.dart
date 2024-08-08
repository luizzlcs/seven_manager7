import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestore {
  CloudFirestore(String collection)
      : _collection = FirebaseFirestore.instance.collection(collection);

  final CollectionReference _collection;

  CollectionReference get instance => _collection;

  Future<QuerySnapshot> getAll({required Query query}) {
    return query.get();
  }

  Future<DocumentSnapshot> get({required String documentId}) {
    return _collection.doc(documentId).get();
  }

  void delete({required String documentId}) {
    _collection.doc(documentId).delete();
  }

  Future<void> update(
      {required String documentId, required Map<String, dynamic> data}) {
    return _collection.doc(documentId).set(data);
  }

  Future<DocumentReference> create({required Map<String, dynamic> data}) {
    return _collection.add(data);
  }

  Future<QuerySnapshot> getByField(
      {required String fieldName, required dynamic value}) {
    return _collection.where(fieldName, isEqualTo: value).limit(1).get();
  }

  Future<void> createDocumentWithSpecificId(
    String collectionName,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    final collection = FirebaseFirestore.instance.collection(collectionName);
    await collection.doc(documentId).set(data);
  }
}
