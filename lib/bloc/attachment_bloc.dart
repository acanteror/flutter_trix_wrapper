import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart';
import 'package:flutter_trix_wrapper/bloc/bloc_base.dart';

class AttachmentBloc extends BlocBase {
  final _attachmentStream = BehaviorSubject<Map<String, MultipartFile>>();
  Stream<Map<String, MultipartFile>> get stream => _attachmentStream.stream;
  Map<String, MultipartFile> get files => _attachmentStream.value;
  Uuid _uuid = Uuid();

  String putFile(MultipartFile file) {
    if (files == null) {
      _setFiles(Map<String, MultipartFile>());
    }
    String fileUUID = _fileUUID();
    files[fileUUID] = file;
    return fileUUID;
  }

  MultipartFile removeFile(String fileUUID) {
    return files.remove(fileUUID);
  }

  void emptyAttachments() {
    _setFiles(Map<String, MultipartFile>());
  }

  List<Map<String, dynamic>> fileList() {
    return files != null
        ? files
            .map((key, file) => MapEntry(key, {'id': key, 'file': file}))
            .values
            .toList()
        : null;
  }

  void _setFiles(Map<String, MultipartFile> files) {
    _attachmentStream.sink.add(files);
  }

  String _fileUUID() {
    return _uuid.v1();
  }

  @override
  void dispose() {
    _attachmentStream.close();
  }
}
