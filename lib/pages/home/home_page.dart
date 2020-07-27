import 'package:flutter_trix_wrapper/pages/first/first_page.dart';
import 'package:flutter_trix_wrapper/pages/second/second_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trix_wrapper/config/app_config.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.APP_NAME),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 200,
            child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Get.to(FirstPage());
              },
              child: Text(
                "To First Page",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 200,
            child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Get.to(SecondPage());
              },
              child: Text(
                "To Second Page",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
