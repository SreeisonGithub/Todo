import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:todos/services/auth_service.dart';

class Storage {
  FirebaseStorage storage =
      FirebaseStorage.instanceFor(bucket: 'gs://todos-eda4b.appspot.com');
  var user = AuthenticationService().getCurrentFirebaseUser().email;


  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await storage.ref('user/profile/$user').putFile(file);
    } on Exception catch (e) {
      print(e.toString());
      // e.g, e.code == 'canceled'
    }
  }
}
