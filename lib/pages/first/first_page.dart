import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trix_wrapper/bloc/trix_cubit.dart';
import 'package:flutter_trix_wrapper/html_editor/trix_html_editor.dart';

GlobalKey<TrixHtmlEditorState> keyEditor1 = GlobalKey();

class FirstPage extends StatelessWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'.toUpperCase()),
      ),
      body: TrixHtmlEditor(
        key: keyEditor1,
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
    keyEditor1.currentState.getText().then((html) {
      Get.find<TrixCubit>().add(html);
      keyEditor1.currentState.setEmpty();
    });
  }
}
