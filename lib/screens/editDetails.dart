import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todos/screens/myHomePage.dart';
import 'package:todos/services/db_service.dart';
import 'package:todos/services/storageService.dart';

class Details extends StatefulWidget {
  const Details({Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: ()async => false,
          child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
          title: Text('Create your profile'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  InkWell(
                    onTap: () async {
                      PickedFile image = await ImagePicker()
                          .getImage(source: ImageSource.gallery);
                      print(image.path);
                      File imageFile = File(image.path);
                      Storage().uploadFile(imageFile.path);
                    },
                    child: Container(
                      alignment: Alignment(0.0, 2.5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.0),
                        ),
                        child: Icon(Icons.photo_camera),
                      ),
                    ),
                  ),
                  TextField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      hintStyle:
                          TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      hintStyle:
                          TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      if (firstNameController.text == '' ||
                          lastNameController.text == '') {
                        SnackBar(
                          content: Text('Enter the fields before submitting'),
                          action: SnackBarAction(
                            onPressed: null,
                            label: 'Undo',
                          ),
                        );
                      } else {
                        print(firstNameController.text);
                        print(lastNameController.text);
                        DbService()
                            .addUser(
                                firstNameController.text, lastNameController.text)
                            .then(
                              (_) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(),
                                ),
                              ),
                            );
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
