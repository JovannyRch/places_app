import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsPovider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream => _mensajesStreamController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();

    print('================FCM Token ========================');
    print(token);

    // My token cU8ULGuAR9qIf9lw-fri_u:APA91bEHydw0dqjOXPWMM2hCEUhVD6CRHWwjDzsY1UdOd_5uK4dNmXZx23MjW58oCrcAiCzhrNhzrhjeYXDNXrX_-JTi5PUPDs3ZZ_2tRvzOtTFVe8-YVSxdnam1Jt616RRilfZtsw95

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  getToken<String>() async {
    final token = await _firebaseMessaging.getToken();
    return token;
  }

  // TODO: recibir argumentos

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('====== onMessage =======');
    print('message: $message');

    final argumento = message['data']['uid'] ?? 'no-data';
    print(argumento);
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('====== onLaunch =======');
    print('message: $message');

    final argumento = message['data']['uid'] ?? 'no-data';
    print(argumento);
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('====== onResume =======');
    print('message: $message');

    final argumento = message['data']['uid'] ?? 'no-data';
    print(argumento);
    _mensajesStreamController.sink.add(argumento);
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
