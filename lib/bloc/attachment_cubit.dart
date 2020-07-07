import 'package:cubit/cubit.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart';

class AttachmentCubit extends Cubit<Map<String, MultipartFile>> {
  final Uuid _uuid;
  AttachmentCubit({uuid})
      : _uuid = uuid ?? Uuid(),
        super(Map<String, MultipartFile>());

  String putFile(MultipartFile file) {
    String fileUUID = _fileUUID();
    state[fileUUID] = file;
    return fileUUID;
  }

  MultipartFile removeFile(String fileUUID) {
    return state.remove(fileUUID);
  }

  void emptyAttachments() {
    state.clear();
  }

  List<Map<String, dynamic>> fileList() {
    return state
        .map((key, file) => MapEntry(key, {'id': key, 'file': file}))
        .values
        .toList();
  }

  String _fileUUID() {
    return _uuid.v1();
  }
}
