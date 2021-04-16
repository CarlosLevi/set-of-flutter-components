import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImagePage extends StatefulWidget {
  final String path;

  DisplayImagePage(this.path);

  @override
  _DisplayImagePageState createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Display Image Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(widget.path)),
            ),
          ),
        ),
      ),
    );
  }
}
