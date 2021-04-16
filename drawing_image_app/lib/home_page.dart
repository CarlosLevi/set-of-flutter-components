import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as UI;

import 'package:drawing_image_app/json_example.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UI.Image _canvasImage;

  void _loadImage() async {
    File file = await urlToFile();
    final data = await file.readAsBytes();
    UI.Image image = await decodeImageFromList(data);
    print(image.height);
    setState(() {
      _canvasImage = image;
    });
  }

  Future<File> urlToFile() async {
    var bytes = await rootBundle.load('assets/19AINE002639852225_1.jpg');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing on Images'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FittedBox(
          child: SizedBox(
            height: _canvasImage.height.toDouble(),
            width: _canvasImage.width.toDouble(),
            child: CustomPaint(
              painter: MyPainter(_canvasImage),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.image);

  final pointMode = UI.PointMode.polygon;
  final List<Offset> points = JsonExample().points;
  final List<Offset> pointsS1 = JsonExample().pointsS1;
  final UI.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    // final double screenHeight = size.height;
    // final double screenWidth = size.width;

    // List<Offset> normalizedPoints = [];
    // List<Offset> normalizedPointsS1 = [];

    // for (Offset p in points) {
    //   double normalizedX = p.dx - image.width;
    //   double normalizedY = p.dy - image.height;

    //   if (normalizedX < 0) normalizedX = normalizedX * -1;
    //   if (normalizedY < 0) normalizedY = normalizedY * -1;

    //   normalizedPoints.add(Offset(normalizedX, normalizedY));
    // }

    // for (Offset p in pointsS1) {
    //   double normalizedX = p.dx - image.width;
    //   double normalizedY = p.dy - image.height;

    //   if (normalizedX < 0) normalizedX = normalizedX * -1;
    //   if (normalizedY < 0) normalizedY = normalizedY * -1;

    //   normalizedPointsS1.add(Offset(normalizedX, normalizedY));
    // }

    // print('NORMALIZED POINTS:');
    // print(normalizedPoints);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Colors.red;

    final paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Colors.green;

    canvas.drawImage(image, Offset.zero, paint);
    canvas.drawPoints(pointMode, points, paint);
    canvas.drawPoints(pointMode, pointsS1, paint2);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;
}
