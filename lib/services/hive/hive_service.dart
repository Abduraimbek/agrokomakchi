import 'package:hive_flutter/hive_flutter.dart';

class HiveKeys {
  static const isRegistered = "is_registered";

  static const intUserId = "int_user_id";
}

class SavedData {
  static late bool isRegistered;

  static late int intUserId;

  static Map<String, dynamic> getData() {
    return <String, dynamic>{
      // bool
      HiveKeys.isRegistered:
          myBox.get(HiveKeys.isRegistered, defaultValue: false),

      // int
      HiveKeys.intUserId: myBox.get(HiveKeys.intUserId, defaultValue: 0),
    };
  }

  static setData(Map<String, dynamic> map) {
    isRegistered = map[HiveKeys.isRegistered];

    intUserId = map[HiveKeys.intUserId];
  }
}

class HiveService {
  static final HiveService _hiveService = HiveService._private();

  HiveService._private();

  factory HiveService() => _hiveService;

  //******************************************************
  //******************************************************
  // bool
  //******************************************************
  //******************************************************

  Future<void> saveIsRegistered(bool value) async {
    await myBox.put(HiveKeys.isRegistered, value);
    SavedData.isRegistered = value;
  }

  //******************************************************
  //******************************************************
  // int
  //******************************************************
  //******************************************************

  Future<void> saveIntUserId(int value) async {
    await myBox.put(HiveKeys.intUserId, value);
    SavedData.intUserId = value;
  }

  //******************************************************
  //******************************************************
  // Initializing
  //******************************************************
  //******************************************************

  Future<void> initialize() async {
    await Hive.initFlutter();
    myBox = await Hive.openBox("my_box");
    SavedData.setData(SavedData.getData());
  }
}

late Box<dynamic> myBox;
