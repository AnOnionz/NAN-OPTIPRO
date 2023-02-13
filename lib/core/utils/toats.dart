import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../widgets/custom_toast.dart';


void showToast({required String message, required Color color, Icon? icon}){
  SmartDialog.dismiss(status: SmartStatus.toast);
  SmartDialog.showToast('',
      builder: (context) => CustomToast(msg: message, color: color, icon: icon,),
      displayTime: const Duration(milliseconds: 1000));
}