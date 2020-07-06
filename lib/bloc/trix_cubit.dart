import 'package:cubit/cubit.dart';
import 'package:flutter_trix_wrapper/pages/result/result_page.dart';
import 'package:get/get.dart' as getx;

class TrixCubit extends Cubit<String> {
  TrixCubit() : super('');

  void add(String html) {
    if (html.isNotEmpty) {
      getx.Get.to(ResultPage());
      emit(html);
    } else {
      print('error html empty');
    }
  }

  @override
  void onTransition(Transition<String> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
