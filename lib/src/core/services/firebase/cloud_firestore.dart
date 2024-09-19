import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<QuerySnapshot> getAll(
      {required String collection, required Query query}) async {
    return _firestore.collection(collection).where(query).get();
  }

  Future<DocumentSnapshot> get(
      {required String collection, required String documentId}) {
    return _firestore.collection(collection).doc(documentId).get();
  }

  void delete({required String collection, required String documentId}) {
    _firestore.collection(collection).doc(documentId).delete();
  }

  Future<void> update(
      {required String collection,
      required String documentId,
      required Map<String, dynamic> data}) {
    return _firestore.collection(collection).doc(documentId).set(data);
  }

  Future<DocumentReference> create(
      {required String collection, required Map<String, dynamic> data}) {
    return _firestore.collection(collection).add(data);
  }

  Future<QuerySnapshot> getByField(
      {required String collection,
      required String fieldName,
      required dynamic value}) {
    return _firestore
        .collection(collection)
        .where(fieldName, isEqualTo: value)
        .limit(1)
        .get();
  }

  Future<void> createDocumentWithSpecificId({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).doc(documentId).set(data);
  }
}
