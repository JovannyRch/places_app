import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../const/const.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    TextEditingController _emailController;
    TextEditingController _passwordController;
    TextEditingController _nameController;
    TextEditingController _apellidoPaternoController;
    TextEditingController _apellidoMaternoController;
    TextEditingController _rePasswordController;
    bool isSubmitting = false;
/* 
    final logo = Image.asset(
      "assets/logo.png",
      height: mq.size.height / 4,
    ); */
    final nameField = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          hintText: "Ingrese su nombre(s)",
          labelText: "Nombre",
          hintStyle: TextStyle(color: kBaseColor)),
    );

    final apellidoPaternoField = TextFormField(
      controller: _apellidoPaternoController,
      keyboardType: TextInputType.name,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          hintText: "Ingrese su apellido paterno",
          labelText: "Apellido Paterno",
          hintStyle: TextStyle(color: kBaseColor)),
    );

    final apellidoMaternoField = TextFormField(
      controller: _apellidoMaternoController,
      keyboardType: TextInputType.name,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          hintText: "Ingrese su apellido materno",
          labelText: "Apellido Materno",
          hintStyle: TextStyle(color: kBaseColor)),
    );

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

    final passwordField = TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          hintText: "Ingrese su contraseña",
          labelText: "Contraseña",
          hintStyle: TextStyle(color: kBaseColor)),
    );

    final rePasswordField = TextFormField(
      controller: _rePasswordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          hintText: "Ingrese nuevamente su contraseña",
          labelText: "Confirme su contraseña",
          hintStyle: TextStyle(color: kBaseColor)),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          nameField,
          apellidoPaternoField,
          apellidoMaternoField,
          emailField,
          passwordField,
          rePasswordField
        ],
      ),
    );

    final registerButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(25.0),
        color: kBaseColor,
        child: MaterialButton(
          minWidth: mq.size.width / 1.2,
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Text("Registrarse",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          onPressed: () async {
            try {
              UserCredential user = (await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text));
              print(user);

              if (user != null) {
                user.user.updateProfile(displayName: _nameController.text);
                Navigator.of(context).popAndPushNamed('login');
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
              _emailController.clear();
              _nameController.clear();
              _apellidoMaternoController.clear();
              _apellidoPaternoController.clear();
              _passwordController.clear();
              _rePasswordController.clear();
            }
          },
        ));

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "¿Ya tienes una cuenta?",
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
                Navigator.of(context).pushNamed('login');
              },
              child: Text(
                "Iniciar Sesión",
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
                  padding: EdgeInsets.only(bottom: 50),
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
