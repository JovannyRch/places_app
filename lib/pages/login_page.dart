import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    TextEditingController _emailController;
    TextEditingController _passwordController;
    bool isSubmitting = false;

    final emailField = TextFormField(
      enabled: isSubmitting,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.red,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
          )),
          hintText: "Ingrese su correo electrónico",
          labelText: "Correo Electrónico",
          hintStyle: TextStyle(color: Colors.red)),
    );

    final passwordField = Column(children: <Widget>[
      TextFormField(
        enabled: isSubmitting,
        controller: _passwordController,
        keyboardType: TextInputType.visiblePassword,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            hintText: "Ingrese su contraseña",
            labelText: "Contraseña",
            hintStyle: TextStyle(color: Colors.red)),
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
                    .copyWith(color: Colors.red)),
            onPressed: () {
              //Forget password
            },
          )
        ],
      )
    ]);

    final fields = Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[emailField, passwordField],
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "¿Aun no tienes una cuenta?",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black),
            ),
            MaterialButton(
              child: Text(
                "Registrarse",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white, decoration: TextDecoration.underline),
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[fields, bottom]),
          )),
    );
  }
}
