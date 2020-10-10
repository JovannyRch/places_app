import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../const/const.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    bool isSubmitting = false;
/* 
    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 4,
    ); */

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          hintText: "Ingrese su correo electrónico",
          labelText: "Correo Electrónico",
          hintStyle: TextStyle(color: kBaseColor)),
    );

    final passwordField = Column(children: <Widget>[
      TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            hintText: "Ingrese su contraseña",
            labelText: "Contraseña",
            hintStyle: TextStyle(color: kBaseColor)),
      ),
      Padding(padding: EdgeInsets.all(2.0)),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          MaterialButton(
            child: Text("Olvide mi contraseña",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: kBaseColor)),
            onPressed: () {
              //Forget password
            },
          )
        ],
      )
    ]);

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[emailField, passwordField],
      ),
    );

    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(25.0),
        color: kBaseColor,
        child: MaterialButton(
          minWidth: mq.size.width / 1.2,
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Text("Iniciar Sesión",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          onPressed: () async {
            try {
              UserCredential user = (await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text));
              print(user);
              if (user != null) {
                Navigator.of(context).popAndPushNamed('home');
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            } catch (e) {
              print('error $e');
              _emailController.clear();
              _passwordController.clear();
            }

            Navigator.of(context).popAndPushNamed('home');
          },
        ));

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "¿Aun no tienes cuenta?",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('register');
              },
              child: Text(
                "Registrarse",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: kBaseColor, decoration: TextDecoration.underline),
              ),
            )
          ],
        )
      ],
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //logo
                fields,
                Padding(
                  padding: EdgeInsets.only(bottom: 150),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
