import 'package:flutter_trix_wrapper/config/app_config.dart';
import 'package:flutter_trix_wrapper/path_resolver/path_resolver.dart';

class ServerPathResolver extends PathResolver {
  @override
  String resolve(filePath) {
    return 'http://localhost:${AppConfig.PORT}/$filePath';
  }
}
