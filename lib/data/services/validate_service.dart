String? Function(String?) validateCount = (value){
  var count = int.tryParse(value!);
  if(count == null) {
    return "Vui lòng nhập giá trị hợp lệ";
  } else if(count < 0) {
    return "Vui lòng nhập giá trị lớn hơn 0";
  }
  return null;
};

String? Function(String?) validatePositiveDouble = (value){
  var count = double.tryParse(value!);
  if(count == null) {
    return "Vui lòng nhập giá trị hợp lệ";
  } else if(count < 0) {
    return "Vui lòng nhập giá trị lớn hơn 0";
  }
  return null;
};

