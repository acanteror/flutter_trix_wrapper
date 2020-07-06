import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trix_wrapper/di/inyector.dart';
import 'package:flutter_trix_wrapper/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configInyector();
  _initServer();

  runApp(MyApp());
}

_initServer() {
  if (Platform.isIOS) {
    Get.find<InAppLocalhostServer>().start();
  }
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
