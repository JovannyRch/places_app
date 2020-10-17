import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:places_app/components/blur_container.dart';
import 'package:places_app/helpers/alerts_helper.dart';
import 'package:places_app/models/usuario_model.dart';
import 'package:places_app/providers/push_notification_provider.dart';

import 'package:places_app/routes/routes.dart';
import 'package:places_app/shared/user_preferences.dart';

import '../const/const.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _apellidoPaternoController = TextEditingController();
  TextEditingController _apellidoMaternoController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  PushNotificationsPovider _pushNotificationProvider =
      PushNotificationsPovider();
  MediaQueryData mq;
  bool isAfiliado = false;
  UserPreferences preferences = new UserPreferences();
  bool isSubmitting = false;

  void handleRegister() async {
    try {
      setState(() {
        isSubmitting = true;
      });
      if (!_formKey.currentState.validate()) {
        setState(() {
          isSubmitting = false;
        });
        return;
      } else {
        final tokenPush = await _pushNotificationProvider.getToken();
        print('TOKENNNNNNNN -> $tokenPush');
        _formKey.currentState.save();
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.toLowerCase(),
                password: _passwordController.text)
            .catchError((onError) {
          print('ERRRRRRROOOOOOOOR');
          print(onError);
          showAlert(context, 'Algo salio mal...', onError.toString());
        });
        print(user.user.email);

        if (user != null) {
          print("El usuario fue registrado correctamente");
          if (isAfiliado) {
            Usuario usuario = new Usuario(
                tipoUsuario: "afiliado",
                apellidoMaterno: _apellidoMaternoController.text,
                apellidoPaterno: _apellidoPaternoController.text,
                correo: _emailController.text,
                licencia: "",
                nombre: _nameController.text,
                placa: "",
                seguro: "",
                tokenPush: tokenPush);
            await usuario.save(_emailController.text);
            preferences.email = _emailController.text.toLowerCase();
            preferences.tipoUsuario = "afiliado";
          } else {
            Usuario usuario = new Usuario(
                tipoUsuario: "normal",
                apellidoMaterno: _apellidoMaternoController.text,
                apellidoPaterno: _apellidoPaternoController.text,
                correo: _emailController.text,
                licencia: "",
                nombre: _nameController.text,
                placa: "",
                seguro: "",
                tokenPush: tokenPush);
            await usuario.save(_emailController.text);
            preferences.email = _emailController.text.toLowerCase();
            preferences.tipoUsuario = "normal";
            Navigator.pushReplacementNamed(context, registerExtra,
                arguments: _emailController.text);
          }
          await user.user.updateProfile(displayName: _nameController.text);
          success(context, "Cuenta creada", "Su registro ha sido exitoso",
              f: () {
            Navigator.pushReplacementNamed(context, home);
          });
          setState(() {
            isSubmitting = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        isSubmitting = false;
      });
      print('error $e');
      /*  _emailController.clear();
      _nameController.clear();
      _apellidoMaternoController.clear();
      _apellidoPaternoController.clear();
      _passwordController.clear();
      _rePasswordController.clear(); */
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    final logo = Image.asset(
      "assets/images/logo.png",
      height: isAfiliado ? (mq.size.height / 16) : (mq.size.height / 8),
    );
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
        validator: (String value) {
          if (value.isEmpty) {
            return 'Ingrese su nombre(s)';
          }

          if (value.trim().length < 3) {
            return 'Su nombre debe contener al menos 3 caracteres';
          }

          return null;
        },
        onSaved: (String value) {
          _nameController.text = value;
        });

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
        validator: (String value) {
          if (value.isEmpty) {
            return 'Ingrese su apellido paterno';
          }

          if (value.trim().length < 3) {
            return 'Su apellido debe contener al menos 3 caracteres';
          }

          return null;
        },
        onSaved: (String value) {
          _apellidoPaternoController.text = value;
        });

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
        validator: (String value) {
          if (value.isEmpty) {
            return 'Ingrese su apellido materno';
          }

          if (value.trim().length < 3) {
            return 'Su apellido debe contener al menos 3 caracteres';
          }

          return null;
        },
        onSaved: (String value) {
          _apellidoMaternoController.text = value;
        });

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
        validator: (String value) {
          if (value.isEmpty) {
            return 'Ingrese su contraseña';
          }

          if (value.length < 6) {
            return 'Su contraseña debe contener al menos 6 caracteres';
          }

          return null;
        },
        onSaved: (String value) {
          _passwordController.text = value;
        });

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
        validator: (String value) {
          if (value.isEmpty) {
            return 'Ingrese nuevamente su contraseña';
          }

          if (value.length < 6) {
            return 'Su contraseña debe contener al menos 6 caracteres';
          }

          if (value != _passwordController.text) {
            return 'Las contraseñas no coinciden';
          }

          return null;
        },
        onSaved: (String value) {
          _rePasswordController.text = value;
        });

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
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
        child: Text(
          !isAfiliado ? "Registrarse" : "Continuar",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: handleRegister,
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        SizedBox(height: 10.0),
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
            /* Padding(padding: EdgeInsets.only(bottom: 10.0)) */
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('login', (route) => false);
              },
              child: Text(
                "Iniciar Sesión",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: kBaseColor, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          MaterialButton(
            onPressed: () {
              setState(() {
                isAfiliado = !isAfiliado;
              });
            },
            child: Text(
              !isAfiliado ? "Registrarse como afiliado" : "Registro normal",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: kBaseColor,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ])
      ],
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlurContainer(
          isLoading: isSubmitting,
          text: "Registrando usuario",
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 36.0),
              child: Container(
                height: mq.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logo,
                    !isAfiliado
                        ? Text(
                            "Registro de usuario",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                "Paso 1",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Registro de usuario afiliado",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                    fields,
                    bottom,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context, String title, String error) {
    var messageError;

    switch (error) {
      case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
        messageError =
            'El correo electrónico ya se encuentra vinculado a una cuenta registrada, por favor inicie sesión';
        break;
      default:
        messageError = 'Verifique su correo y contraseña';
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(title),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Text(messageError)]),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil('register', (route) => false),
                  child: Text('OK',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: kBaseColor)))
            ],
          );
        });
  }
}
