import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trix_wrapper/config/app_config.dart';
import 'package:flutter_trix_wrapper/bloc/trix_cubit.dart';
import 'package:flutter_trix_wrapper/html_editor/trix_html_editor.dart';

GlobalKey<TrixHtmlEditorState> keyEditor = GlobalKey();

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.APP_NAME),
      ),
      body: TrixHtmlEditor(
        key: keyEditor,
        hint: 'Insert text...',
        color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submit();
        },
        tooltip: 'Submit',
        child: Icon(Icons.send),
      ),
    );
  }

  void _submit() {
    keyEditor.currentState.getText().then((html) {
      Get.find<TrixCubit>().add(html);
      keyEditor.currentState.setEmpty();
    });
  }
}
