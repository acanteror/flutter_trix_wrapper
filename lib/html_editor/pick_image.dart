import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef void CallbackValue(dynamic value);

class PickFile extends StatelessWidget {
  final CallbackValue callbackFile;
  final Color color;

  PickFile({this.callbackFile, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _PickerButton(
                        callbackFile: callbackFile,
                        color: color,
                        text: 'Gallery',
                        icon: Icons.image,
                        picker: GalleryFilePicker())
                    .build(context),
                _PickerButton(
                        callbackFile: callbackFile,
                        color: color,
                        text: 'Camera',
                        icon: Icons.camera_alt,
                        picker: CameraFilePicker())
                    .build(context),
                _PickerButton(
                        callbackFile: callbackFile,
                        color: color,
                        icon: Icons.attach_file,
                        text: 'File',
                        picker: CustomFilePicker())
                    .build(context)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PickerButton {
  final CallbackValue callbackFile;
  final Color color;
  final String text;
  final bool isCamera;
  final IconData icon;
  final Picker picker;

  _PickerButton(
      {this.callbackFile,
      this.color,
      this.text,
      this.isCamera,
      this.icon,
      this.picker});

  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).primaryColorLight;
    return FlatButton(
        padding: const EdgeInsets.all(10),
        onPressed: () {
          pickFile();
          Navigator.pop(context);
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                this.icon,
                color: _color,
                size: 44,
              ),
              Text(
                this.text,
                style: TextStyle(color: _color),
              )
            ]));
  }

  pickFile() {
    picker.pick().then((image) {
      if (image != null) {
        callbackFile(image);
      }
    });
  }
}

abstract class Picker {
  Future<File> pick();
}

class CustomFilePicker extends Picker {
  Future<File> pick() {
    return FilePicker.getFile(type: FileType.custom, allowedExtensions: [
      "jpg",
      "jpeg",
      "png",
      "gif",
      "svg",
      "icon",
      "zip",
      "rar",
      "7z",
      "gzip",
      "tar",
      "gz",
      "wav",
      "mp3",
      "webm",
      "mpg",
      "mp2",
      "mpeg",
      "mpe",
      "mpv",
      "ogg",
      "mp4",
      "m4p",
      "m4v",
      "avi",
      "wmv",
      "mov",
      "qt",
      "flv",
      "swf",
      "avchd",
      "pdf",
      "xls",
      "xlsx",
      "doc",
      "docx",
      "ppt",
      "pptx",
      "txt",
      "csv",
      "odt",
      "ott",
      "oth",
      "odm",
      "odp",
    ]);
  }
}

class CameraFilePicker extends Picker {
  Future<File> pick() {
    return ImagePicker.pickImage(source: ImageSource.camera);
  }
}

class GalleryFilePicker extends Picker {
  Future<File> pick() {
    return FilePicker.getFile(type: FileType.image);
  }
}
