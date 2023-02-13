import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../common/constants.dart';

String priceToString(int price, {String? symbol, String? country}) {
  String s = symbol ?? '.';
  String c = country ?? 'vnd';
  if (price == 0) {
    return '0';
  }
  final a = NumberFormat.decimalPattern('vi',).format(price);

  return '$a $c';
}


bool fieldIsEmpty(TextEditingController controller) {
  return controller.text.replaceAll(' ', '') == '';
}

DateTime localTime() {
  var now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

MapEntry<String, Color> ballotStatus(String text){
  switch(text){
    case 'pending' : return MapEntry('Chưa hoàn thành', kRedCentColor);
    case 'approved' : return MapEntry('Hoàn thành', kGreenColor);
    case 'cancelled' : return MapEntry('Đã hủy', kRedCentColor);
    default: return MapEntry(text , kGreyTextColor);
  }
}
MapEntry<String, Color> allocationRequestStatus(String text){
  switch(text){
    case 'pending' : return MapEntry('Chưa hoàn thành', kRedCentColor);
    case 'approved' : return MapEntry('Chưa hoàn thành', kRedCentColor);
    case 'completed' : return MapEntry('Hoàn thành', kGreenColor);
    case 'conflicted' : return MapEntry('Hoàn thành', kGreenColor);
    case 'cancelled' : return MapEntry('Đã hủy', kRedCentColor);
    default: return MapEntry(text , kGreyTextColor);
  }
}
