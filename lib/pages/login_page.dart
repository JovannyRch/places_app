import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:places_app/components/blur_container.dart';
import 'package:places_app/helpers/alerts_helper.dart';
import 'package:places_app/routes/routes.dart';
import 'package:places_app/services/facebook_signin_service.dart';
import 'package:places_app/services/google_signin_service.dart';
import 'package:places_app/shared/user_preferences.dart';

import '../const/const.dart';

class LoginPage extends StatefulWidget {
  String email;
  String password;
  LoginPage({this.email = "", this.password = ""});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  UserPreferences preferences = new UserPreferences();
  bool isSubmitting = false;

  @override
  void initState() {
    if (widget.email.isNotEmpty && widget.password.isNotEmpty) {
      //Call login
      doLogin();
    }
    super.initState();
  }

  void doLogin() async {
    UserCredential user = await signIn(widget.email, widget.password);
    if (user != null) {
      preferences.email = _emailController.text;
      //Check user type
      Navigator.of(context).popAndPushNamed(home);
    }
  }

  void handleGoHome({UserCredential userCredential = null, User user = null}) {
    setSubmitting(false);
    if (user != null || userCredential != null) {
      preferences.email = _emailController.text;
      Navigator.of(context).popAndPushNamed(home);
    }
  }

  void setSubmitting(bool val) {
    setState(() {
      isSubmitting = val;
    });
  }

  void handleLoginEmailPassword() async {
    setSubmitting(true);
    if (!_formKey.currentState.validate()) {
      setSubmitting(false);
      return;
    }
    _formKey.currentState.save();

    UserCredential user =
        await signIn(_emailController.text, _passwordController.text);
    handleGoHome(userCredential: user);
  }

  void handleLoginWithGoogle() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    User user = await GoogleSignInService.signInWithGoogle();
    handleGoHome(user: user);
  }

  void handleLoginWithFacebook() async {
    UserCredential user = await FacebookSignInService.signInWithFacebook();
    handleGoHome(userCredential: user);
  }

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
            hintText: "Ingrese su correo electrónico",
            labelText: "Correo Electrónico",
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
          validator: (String value) {
            if (value.isEmpty) {
              return 'Ingrese su contraseña';
            }

            return null;
          },
          onSaved: (String value) {
            _passwordController.text = value;
          }),
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
              Navigator.of(context).popAndPushNamed('resetPassword');
            },
          )
        ],
      )
    ]);

    final fields = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[emailField, passwordField],
    );

    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(25.0),
        color: kBaseColor,
        child: MaterialButton(
          minWidth: mq.size.width / 1.2,
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Text("Iniciar Sesión",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          onPressed: handleLoginEmailPassword,
        ));

    final facebookLoginButton = FloatingActionButton(
      heroTag: "google",
      backgroundColor: kBaseColor,
      child: Icon(FontAwesomeIcons.facebook, color: Colors.white),
      onPressed: handleLoginWithFacebook,
    );

    final googleLoginButton = FloatingActionButton(
      heroTag: "fb",
      backgroundColor: kBaseColor,
      child: Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: handleLoginWithGoogle,
    );

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
                Navigator.of(context).popAndPushNamed('register');
              },
              child: Text(
                "Registrarse",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: kBaseColor, decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[googleLoginButton, facebookLoginButton],
        )
      ],
    );

    return Scaffold(
      body: BlurContainer(
        isLoading: isSubmitting,
        text: "Iniciando sesión",
        children: [
          Form(
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
        ],
      ),
    );
  }

  Future<UserCredential> signIn(String email, String password) async {
    UserCredential result;
    String errorMessage;

    try {
      result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      print(errorMessage);
      return null;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return result;
  }

  Future<UserCredential> loginEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential user = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password));
      print(user);
      return user;
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
      return null;
    } catch (e) {
      print('error $e');
      _emailController.clear();
      _passwordController.clear();
      return null;
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
