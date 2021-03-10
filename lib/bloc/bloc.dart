import 'dart:async';

import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

  //Add data to stream
  Stream<String> get email => emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  //Change data
  Function(String) get changeEmail => emailController.sink.add;
  Function(String) get changePassword => passwordController.sink.add;

  signUp() async {
    final String validEmail = emailController.value;
    final String validPassword = passwordController.value;

    print('email is $validEmail');
    print('password is $validPassword');
  }

  dispose() {
    emailController.close();
    passwordController.close();
  }
}
