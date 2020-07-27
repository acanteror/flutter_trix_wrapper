import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trix_wrapper/bloc/trix_cubit.dart';
import 'package:flutter_trix_wrapper/html_editor/trix_html_editor.dart';

GlobalKey<TrixHtmlEditorState> keyEditor2 = GlobalKey();

class SecondPage extends StatelessWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'.toUpperCase()),
      ),
      body: TrixHtmlEditor(
        key: keyEditor2,
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
    keyEditor2.currentState.getText().then((html) {
      Get.find<TrixCubit>().add(html);
      keyEditor2.currentState.setEmpty();
    });
  }
}
