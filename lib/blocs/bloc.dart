import 'dart:async';
import 'package:reafel_app/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';


class Bloc extends Object with Validators{

  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();


  //Add data to the stream -> Chocolate factory
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  //Change data -> Order taker
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  String submit(){
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email is: $validEmail');
    print('Password is: $validPassword');

    return validEmail;
  }


  void dispose(){
    _email.close();
    _password.close();
  }

}
