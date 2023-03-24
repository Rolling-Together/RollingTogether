import 'package:firebase_storage/firebase_storage.dart';

final Reference _firebaseStorage = FirebaseStorage.instance.ref();

Future<String> getFirebaseStorageDownloadUrl(String path) async {
  return await _firebaseStorage.child(path).getDownloadURL();
}
