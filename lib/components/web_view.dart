import 'package:flutter/material.dart';
import 'package:places_app/const/const.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatefulWidget {
  String url;

  WebViewComponent(@required this.url);

  @override
  _WebViewComponentState createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBaseColor,
        title: Text("App Tu Taller Mecánico"),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
