class DataCenter {
  static final DataCenter instance = DataCenter._internal();

  factory DataCenter() {
    return instance;
  }

  DataCenter._internal();
}
