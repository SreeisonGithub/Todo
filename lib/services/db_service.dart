
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos/services/auth_service.dart';

class DbService {

  String user = AuthenticationService().getCurrentFirebaseUser().email;


  Future<void> addUser(String firstName, String lastName) {
    CollectionReference users = FirebaseFirestore.instance.collection(user);

    // Call the user's CollectionReference to add a new user
    return users.doc(user)
        .set({
          'first_name': firstName, // John Doe
          'last_name': lastName, // Stokes and Sons
          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

/*firebase_storage.Reference ref =
  firebase_storage.FirebaseStorage.instance.ref();

Future<void> uploadFile(String filePath) async {
  File file = File(filePath);

  try {
    await firebase_storage.FirebaseStorage.instance
        .ref('uploads/file-to-upload.png')
        .putFile(file);
  } on Exception {
    // e.g, e.code == 'canceled'
  }
}*/





}
