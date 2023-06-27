String? Function(String?) validateCount = (value){
  var count = int.tryParse(value!);
  if(count == null || value.contains(".")) {
    return "Giá trị không hợp lệ";
  } else if(count < 0) {
    return "Giá trị nhỏ hơn 0";
  }
  return null;
};

String? Function(String?) validatePositiveDouble = (value){
  var count = double.tryParse(value!);
  print(count);
  if(count == null) {
    return "Giá trị không hợp lệ";
  } else if(count < 0) {
    return "Giá trị nhỏ hơn 0";
  }
  return null;
};

