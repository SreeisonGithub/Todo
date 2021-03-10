import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos/bloc/bloc.dart';
import 'package:todos/screens/myHomePage.dart';
import 'package:todos/screens/signUpScreen.dart';
import 'package:todos/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final bloc = Bloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.only(left: 19.0,right: 14.0, bottom: 26.0),
                  child: emailField(bloc),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19.0,right: 14.0, bottom: 16.0),
                  child: passwordField(bloc),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: submitButton(bloc),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Create an Account', style: TextStyle(color: Colors.white,fontSize: 16.0),),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton(Bloc bloc) {

    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () async {
            await AuthenticationService()
                .signIn(
                    bloc.emailController.value, bloc.passwordController.value)
                .then(
                  (_) => //Navigator.pop(context) );
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  ),
                );
          },
          child: Container(
                      decoration: BoxDecoration(color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Log In', style: TextStyle(color: Colors.white,fontSize: 16.0),),
                      ),
                    ),
        );
      },
    );
  }
}

Widget emailField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.email,
    builder: (context, snapshot) {
      return Material(
        elevation: 10.0,
        color: Colors.white,
        child: Padding(
          padding:
              EdgeInsets.only(left: 40.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "JohnDoe@example.com",
                hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 2.0),
                  child: Icon(Icons.email),
                ),
                errorText: snapshot.error),
          ),
        ),
      );
    },
  );
}

Widget passwordField(Bloc bloc) {
  return StreamBuilder(
    stream: bloc.password,
    builder: (context, snapshot) {
      return Material(
        elevation: 10.0,
        color: Colors.white,
        child: Padding(
          padding:
              EdgeInsets.only(left: 40.0, right: 20.0, top: 10.0, bottom: 10.0),
          child: TextField(
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "123@abc",
                hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 2.0),
                  child: Icon(Icons.lock),
                ),
                errorText: snapshot.error),
            obscureText: true,
          ),
        ),
      );
    },
  );
}
