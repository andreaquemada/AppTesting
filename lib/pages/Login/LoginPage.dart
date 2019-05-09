import 'package:flutter/material.dart';
import 'package:reafel_app/blocs/bloc.dart';
import 'package:reafel_app/blocs/provider.dart';
import 'package:reafel_app/blocs/reafel_bloc.dart';
import 'package:reafel_app/data/data_dtos.dart';
import 'package:reafel_app/models/user_model.dart';
import 'package:reafel_app/pages/HomePage.dart';
import 'package:reafel_app/pages/Login/style.dart';
import 'package:reafel_app/pages/TabPage.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  const LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  TextEditingController emailController = TextEditingController(
      text: '');
  TextEditingController passwordController = TextEditingController(
      text: '');
  UserModel user = UserModel(User());
  var reafelBloc = ReafelBloc();

  LoginPageState() : super();

  Widget skipButton(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topEnd,
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        elevation: 0.0,
        color: Colors.teal.withOpacity(0.5),
        child: MaterialButton(
          minWidth: 32.0,
          height: 24.0,
          onPressed: () {
            //Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(MainTabs.tag);
          },
          child: Text('Skip', style: skip),
        ),
      ),
    );
  }

  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 88.0,
      child: Image.asset('assets/logo.png'),
    ),
  );

  final appName = Center(
    child: Text(
      'Heart Wave',
      style: styleAppName,
    ),
  );

  final forgotLabel = FlatButton(
    child: Text(
      'Forgot password?',
      style: TextStyle(color: Colors.black54),
    ),
    onPressed: () {},
  );

  Widget emailField() {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'yourname@xmail.com',
        //errorText: 'Wrong email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  Widget passwordField() {
    return TextField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
        //errorText: 'Wrong password',
        contentPadding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  Widget loginButton(ReafelBloc reafelBloc) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.teal.shade100,
        elevation: 5.0,
        color: Colors.teal,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            setState(() {
              user.email = emailController.text;
              user.password = passwordController.text;
              bool loggedIn = reafelBloc.authenticate(user.user);
              loggedIn
                  ? Navigator.of(context).pushReplacementNamed(HomePage.tag)
                  : print('The user or password is wrong');
            });
          },

          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

    @override
    Widget build(context) {
      final bloc = ReafelBloc();

      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              skipButton(context),
              logo,
              appName,
              SizedBox(height: 58.0),
              emailField(),
              SizedBox(height: 8.0),
              passwordField(),
              SizedBox(height: 24.0),
              loginButton(bloc),
            ],
          ),
        ),
      );
    }
  }

