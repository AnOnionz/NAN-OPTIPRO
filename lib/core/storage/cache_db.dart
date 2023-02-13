import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CacheDB {
  Future<String> get _localPath async {
    var path = await getApplicationDocumentsDirectory();
    final Directory _appCacheDirFolder = Directory('$path/CacheInSa22');
    var status = await Permission.storage.status;
    var status1 = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    if (status1.isDenied) {
      await Permission.manageExternalStorage.request();
    }
    if (await _appCacheDirFolder.exists()) {
      return _appCacheDirFolder.path;
    } else {
      final Directory _appDocDirNewFolder =
      await _appCacheDirFolder.create(recursive: false);
      return _appDocDirNewFolder.path;
    }
  }

  Future<File> zipLog() async {
    var status = await Permission.storage.status;
    var status1 = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    if (status1.isDenied) {
      await Permission.manageExternalStorage.request();
    }
    final dir = await _localPath;
    final sourceDir = await path_provider.getApplicationDocumentsDirectory();
    final zipFile = await File('$dir/backup.zip').create(recursive: true);
    try {
      //await ZipFile.createFromDirectory(sourceDir: sourceDir, zipFile: zipFile);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return zipFile;
  }

  Future<File> get logFile async {
    var status = await Permission.storage.status;
    var status1 = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
    if (status1.isDenied) {
      await Permission.manageExternalStorage.request();
    }
    final path = await _localPath;
    return File('$path/log.txt');
  }

  Future<String?> readLog() async {
    // try {
    //   late File file;
    //   file = await logFile;
    //   // Read the file
    //   if (file.existsSync()) {
    //     String contents = await file.readAsString();
    //     return contents;
    //   } else {
    //     return '';
    //   }
    // } catch (e) {
    //   return null;
    // }
  }

  Future<void> writeLog({required String json}) async {
    // var status = await Permission.storage.status;
    // if (status.isDenied) {
    //   await Permission.storage.request();
    // }
    // try {
    //   final file = await logFile;
    //   String? oldData = await readLog();
    //   if (oldData != null) {
    //     await file.writeAsString(
    //         '${oldData.isEmpty ? oldData : oldData + '\n'} ${MyDateTime.today + ' Local ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()).replaceAll("/", "-")} ' + ': ' + json}');
    //   }
    // } catch (e) {
    //   if (kDebugMode) {
    //     debugPrint(e);
    //   }
    // }
  }
}
