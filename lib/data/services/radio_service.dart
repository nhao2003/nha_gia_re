import 'package:get/get.dart';

class RadioService {
  List<String> values = [];
  Function? expendedFunc;

  RadioService({
    required this.values,
    this.expendedFunc,
  });

  RxInt selectedValue = 0.obs;

  void onChange(int? val) {
    selectedValue.value = val!;
    if (expendedFunc != null) expendedFunc!();
  }
}
