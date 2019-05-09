

import 'package:reafel_app/data/data_dtos.dart';


class UserModel {
  User user;

  int get userId => user.idUser;
  String get name => user.name;
  DateTime get dob => user.dob;
  String get weight => user.weight;
  String get height => user.height;
  String get gender => user.gender;

  String get email => 'min_ven@gmail.com';
  String get password => '*********';

  void set userId(int userId){
    user.idUser = userId;
  }

  void set name(String name){
    user.name = name;
  }

  void set dob(DateTime dob){
    user.dob = dob;
  }

  void set weight(String weight)
  {
    user.weight = weight;
  }

  void set height(String height)
  {
    user.height = height;
  }

  void set gender(String gender){
    user.gender = gender;
  }

  ///Handle email
  void set email(String email) {
    user.email = email;
  }

  ///Handle password
  void set password(String password) {
    user.password = password;
  }

  ///Result of authentication
  bool get login => true;


  //User toUser() => user;


  UserModel(this.user)
      : assert(user !=
      null, 'A LoginModel must be initialized with a real User.'),
        super() {
    //TODO - initialize
    //user.email = this.email;
    //user.password = this.password;

  }
}


