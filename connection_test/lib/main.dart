import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'verify_connection_page.dart';

void main() => (runApp(MyAppConnection()));

class MyAppConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App for test connection',
          home: VerifyConnectionPage(),
        ),
      );
}
