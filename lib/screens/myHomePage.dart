import 'package:flutter/material.dart';
import 'package:todos/bloc/todoBloc.dart';
import 'package:todos/screens/userProfile.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoBloc bloc = TodoBloc();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Todos'),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserScreen(),
                    ),
                  );
                },
                child: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: bloc.todos,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: Text('Application Error'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    child: Container(
                      width: double.infinity,
                      height: 65.0,
                      child: Center(
                        child: Text(snapshot.data[index].title),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
