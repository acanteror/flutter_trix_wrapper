import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_trix_wrapper/bloc/trix_cubit.dart';
import 'package:flutter_trix_wrapper/config/app_config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.APP_NAME),
      ),
      body: Container(
        child: CubitBuilder<TrixCubit, String>(
          cubit: Get.find<TrixCubit>(),
          builder: (_, html) {
            return Html(
              data: html,
              onLinkTap: (url) {
                launch(url);
              },
            );
          },
        ),
      ),
    );
  }
}
