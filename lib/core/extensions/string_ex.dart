extension StringX on String {
  /// Viết hoa chữ cái đầu
  String capitalize() {
    if (length > 0) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }

    return this;
  }

  double removeTrailingZerosAndNumberfy(String n) {
    if(n.contains('.')){
      return double.parse(
        n.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "") //remove all trailing 0's and extra decimals at end if any
      );
    }
    else{
      return double.parse(
        n
      );
    }
  }

  /// Parse string sang double (trả về default value thay vì throw lỗi)
  double parseDouble([double defaultValue = 0.0]) {
    return double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), '')) ?? defaultValue;
  }

  /// check string is number
  bool isNumeric() {
    if (this == "") {
      return false;
    }
    return double.tryParse(this) != null;
  }
}
