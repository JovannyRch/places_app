import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../const/const.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "assets/images/logo.png",
      height: mq.size.height / 4,
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
            hintText: "Ingrese su correo electrónico registrado",
            labelText: "Correo Electrónico Registrado",
            hintStyle: TextStyle(color: kBaseColor)),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Ingrese su correo electrónico';
          }

          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Ingrese un correo electrónico valido';
          }

          return null;
        },
        onSaved: (String value) {
          _emailController.text = value;
        });

    final fields = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[emailField],
    );

    final resetButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(25.0),
        color: kBaseColor,
        child: MaterialButton(
            minWidth: mq.size.width / 1.2,
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Text("Reestablecer Contraseña",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () async {
              if (!_formKey.currentState.validate()) {
                return;
              } else {
                _formKey.currentState.save();
                bool reset =
                    await resetPassword(_emailController.text, context);
                print('reste result $reset');
                if (reset) {
                  showAlert(context, 'Se ha restablecido su contraseña',
                      'Recibira un correo electrónico desde el cual poodra reestablecer la contraseña de su cuenta');
                } else {
                  showAlert(context, 'Corre electrónico no registrado',
                      'El correo electrónico no ha sido registrado, verifique sus datos');
                }
              }
            }));

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        resetButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed('login');
              },
              child: Text(
                "Cancelar",
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
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 36.0),
          child: Container(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                logo,
                fields,
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on PlatformException catch (err) {
      print('error platform $err');
    } on FirebaseAuthException catch (e) {
      showAlert(context, 'Error',
          'Verifique que su correo y/o contraseña sean correctos');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    } catch (e) {
      print('error $e');
      _emailController.clear();
      return false;
    }
  }

  void showAlert(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(title),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Text(content)]),
            actions: <Widget>[
              FlatButton(
                  onPressed: () =>
                      Navigator.of(context).popAndPushNamed('login'),
                  child: Text('OK'))
            ],
          );
        });
  }
}
