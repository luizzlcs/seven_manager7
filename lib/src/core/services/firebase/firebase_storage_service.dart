import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> deleteImage(String url) async {
    Reference ref = firebaseStorage.refFromURL(url);
    ref.delete();
  }
}
