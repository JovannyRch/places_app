import 'dart:ui';
import 'package:flutter/material.dart';

class BlurContainer extends StatefulWidget {
  final List<Widget> children;
  final String text;
  final Color color;
  bool isLoading = false;
  BlurContainer({
    this.children,
    this.text = "Please wait...",
    this.color,
    this.isLoading,
  });

  @override
  _BlurContainerState createState() => _BlurContainerState();
}

class _BlurContainerState extends State<BlurContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...widget.children,
        blurContainer(text: widget.text),
      ],
    );
  }

  Widget blurContainer({String text = "Please wait"}) {
    if (!widget.isLoading) return Container();
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.grey.withOpacity(0.3),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(widget.color),
              ),
              SizedBox(height: 40.0),
              Text(
                text,
                style: TextStyle(fontSize: 15.0, color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
