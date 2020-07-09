import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_trix_wrapper/bloc/attachment_cubit.dart';
import 'package:flutter_trix_wrapper/bloc/trix_cubit.dart';
import 'package:flutter_trix_wrapper/config/app_config.dart';
import 'package:flutter_trix_wrapper/path_resolver/android_path_resolver.dart';
import 'package:flutter_trix_wrapper/path_resolver/path_resolver.dart';
import 'package:flutter_trix_wrapper/path_resolver/server_path_resolver.dart';
import 'package:get/get.dart';

inyection() {
  if (Platform.isAndroid) {
    Get.put<PathResolver>(AndroidPathResolver());
  }
  if (Platform.isIOS) {
    Get.put<InAppLocalhostServer>(InAppLocalhostServer(port: AppConfig.PORT))
        .start();
    Get.put<PathResolver>(ServerPathResolver());
  }

  Get.lazyPut<TrixCubit>(() => TrixCubit());
  Get.lazyPut<AttachmentCubit>(() => AttachmentCubit());
}
