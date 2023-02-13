import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> init() async {
  var dir = await path_provider.getApplicationDocumentsDirectory();

}

Future<void> initDB(String userKey) async {

}
