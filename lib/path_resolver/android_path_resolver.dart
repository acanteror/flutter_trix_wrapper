import 'package:flutter_trix_wrapper/path_resolver/path_resolver.dart';

class AndroidPathResolver extends PathResolver {
  @override
  String resolve(filePath) {
    return 'file:///android_asset/flutter_assets/$filePath';
  }
}
