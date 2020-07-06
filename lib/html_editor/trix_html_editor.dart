import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_trix_wrapper/bloc/attachment_bloc.dart';
import 'package:flutter_trix_wrapper/html_editor/pick_image.dart';
import 'package:flutter_trix_wrapper/path_resolver/path_resolver.dart';

class TrixHtmlEditor extends StatefulWidget {
  final String value;
  final double height;
  final BoxDecoration decoration;
  final String widthImage;
  final String hint;
  final Color color;

  TrixHtmlEditor({
    Key key,
    this.value,
    this.height = 380,
    this.decoration,
    this.widthImage = "100%",
    this.hint = 'Enter content',
    @required this.color,
  }) : super(key: key);

  @override
  TrixHtmlEditorState createState() =>
      TrixHtmlEditorState(Get.find<PathResolver>());
}

class TrixHtmlEditorState extends State<TrixHtmlEditor> {
  final PathResolver _pathResolver;
  TrixHtmlEditorState(this._pathResolver);

  final Key _mapKey = UniqueKey();
  InAppWebViewController _controller;

  String text = "";

  @override
  void dispose() {
    if (_controller != null) {
      _controller = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.height,
        decoration: widget.decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: InAppWebView(
                key: _mapKey,
                onLoadError: (_controller, string1, integer, string2) {
                  print("error");
                },
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true, debuggingEnabled: true),
                ),
                initialUrl: _pathResolver.resolve('trix/index.html'),
                initialHeaders: {"mimeType": 'text/html', "encoding": 'utf-8'},
                onWebViewCreated: (InAppWebViewController controller) async {
                  _controller = controller;
                  _controller.addJavaScriptHandler(
                      handlerName: 'showBottomSheet',
                      callback: (_) {
                        bottomSheetPickImage(context);
                      });
                },
                onPageCommitVisible:
                    (InAppWebViewController controller, String text) async {
                  await setPlaceholder();
                },
                gestureRecognizers: [
                  Factory(
                      () => VerticalDragGestureRecognizer()..onUpdate = (_) {}),
                ].toSet(),
                onLoadStop: (webViewController, String url) {
                  if (widget.value != null) {
                    setText(widget.value);
                  }
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> getText() {
    return _controller.evaluateJavascript(source: "getText();");
  }

  Future<String> setText(String text) async {
    return _controller.evaluateJavascript(source: "setText('$text');");
  }

  Future<dynamic> setEmpty() async {
    return _controller.evaluateJavascript(source: "setText('');");
  }

  void bottomSheetPickImage(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => PickFile(
            color: Theme.of(context).primaryColor,
            callbackFile: (file) {
              addObject(file);
            }));
  }

  void addObject(File file) {
    String fileName = p.basename(file.path);
    file.readAsBytes().then((List<int> fileBytes) {
      String mime = lookupMimeType(file.path, headerBytes: fileBytes) ??
          'application/octet-stream';
      String fileUUID = Get.find<AttachmentBloc>()
          .putFile(toMultipart(fileName, fileBytes, mime));
      String insertObject =
          "insertFile('$fileName', '$mime', '${getPath(file, fileBytes, mime)}', '$fileUUID')";
      _controller.evaluateJavascript(source: insertObject);
    });
  }

  Future<dynamic> setPlaceholder() async {
    if (Platform.isIOS) {
      await Future.delayed(Duration(milliseconds: 250));
    }
    return _controller.evaluateJavascript(
        source: "setPlaceholder('${widget.hint}');");
  }

  String getPath(File file, List<int> fileBytes, String mime) {
    if (Platform.isIOS && mime.contains(RegExp(r'(?:jpe?g|png|gif)'))) {
      return 'data:$mime;base64,${base64Encode(fileBytes)}';
    } else {
      return file.uri.toString();
    }
  }

  MultipartFile toMultipart(fileName, List<int> fileBytes, String mime) {
    return MultipartFile.fromBytes('file', fileBytes,
        filename: fileName, contentType: MediaType.parse(mime));
  }
}
