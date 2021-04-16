import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:overlay_support/overlay_support.dart';

class VerifyConnectionPage extends StatefulWidget {
  @override
  _VerifyConnectionPageState createState() => _VerifyConnectionPageState();
}

class _VerifyConnectionPageState extends State<VerifyConnectionPage> {
  void _verifyConnection() async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) _showConnectiveSnackBar();
  }

  @override
  void initState() {
    super.initState();
    _verifyConnection();
    Connectivity().onConnectivityChanged.listen((event) {
      final hasConnectio = event != ConnectivityResult.none;
      print(hasConnectio);
      if (hasConnectio == false) _showConnectiveSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Icon(
          Icons.wifi,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  void _showConnectiveSnackBar() => showSimpleNotification(
        Text('Internet Conectivity'),
        subtitle: Text('You have no internet connection'),
        background: Colors.red,
      );
}
