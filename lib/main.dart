import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:medicine_scanner/screens/qr_scanner_page.dart';

 main()  {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QrScannerPage(),
      // home: Container(),
    );
  }
}
