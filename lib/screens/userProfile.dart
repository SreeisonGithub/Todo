import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos/screens/editDetails.dart';
import 'package:todos/services/auth_service.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var user = AuthenticationService().getCurrentFirebaseUser();

  @override
  Widget build(BuildContext context) {
    String user = AuthenticationService().getCurrentFirebaseUser().email;
    CollectionReference users = FirebaseFirestore.instance.collection(user);

    return WillPopScope(onWillPop: ()async => false,
          child: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(),
                  ),
                );
              },
              child: Icon(Icons.edit),
            ),
          ],
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: users.doc(user).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<String, dynamic> data = snapshot.data.data();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        child: Container(
                          alignment: Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    " ${data['first_name']} ${data['last_name']}",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.blueGrey,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      AuthenticationService().signOut().then(
                            (_) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(),
                              ),
                            ),
                          );
                    },
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      elevation: 2.0,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                              letterSpacing: 2.0, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
