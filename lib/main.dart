import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trix_wrapper/di/inyector.dart';
import 'package:flutter_trix_wrapper/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  inyection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Trix Wrapper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
