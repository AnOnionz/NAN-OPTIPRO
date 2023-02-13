import 'package:flutter/foundation.dart';

import '../../core/utils/my_dialog.dart';

class BaseApiProvider{
  void handleError(error) {
  displayError(error);
  debugPrint('APP ERROR : $error');
  throw error;
  }
}