import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class MyDateTime {
  static DateTime day = DateTime.now();
  static String today = DateFormat('dd/MM/yyyy').format(day).replaceAll("/", "-");

  static timeLocal() async {
    final todayStr = await Modular.get<FlutterSecureStorage>().read(key: 'day');
    if (todayStr != null) {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final cacheDate =
          DateTime.parse(DateFormat("dd-MM-yyyy").parse(todayStr).toString())
              .millisecondsSinceEpoch ~/
              1000;
      if (now < cacheDate) {
        today = todayStr;
      } else {
        today = DateFormat('dd/MM/yyyy').format(day).replaceAll("/", "-");
      }
    }
  }
}
