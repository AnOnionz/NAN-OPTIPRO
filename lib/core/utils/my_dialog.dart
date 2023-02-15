import 'dart:io';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flinq/flinq.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/utils/toats.dart';
import '../../core/utils/utils.dart';
import '../../core/widgets/loading_text.dart';
import '../../core/errors/failure.dart';
import '../../core/widgets/custom_loading.dart';
import '../../features/login/blocs/authentication_bloc.dart';
import '../../features/login/blocs/login_bloc.dart';
import 'package:asuka/asuka.dart';

import '../common/constants.dart';

Flushbar<bool?>? flush;

enum DialogType { success, error, warning }

extension DialogTypeExtension on DialogType {
  String get name => describeEnum(this);

  Image get iconDialog {
    switch (this) {
      default:
        return Image.asset(
          'assets/images/canhan.png',
          height: 60,
          width: 60,
        );
    }
  }
}

Future<void> showCupertinoDialogLoading(BuildContext context) async {
  return showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => true,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitFadingCube(
                  size: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color:
                            index.isEven ? Colors.blueAccent : Colors.redAccent,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Đang xử lý...',
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showExchangeLoading() async {
  var custom = Container(
    height: 120,
    width: 180,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 10,
        ),
        LoadingText(
          text: 'Đang xử lí',
        ),
      ],
    ),
  );
  await SmartDialog.showLoading(
    builder: (_) => custom,
    clickMaskDismiss: false,
    backDismiss: false,
  );
}

Future<void> showMessage({
  required DialogType type,
  required String message,
  String? title,
}) async {
  await SmartDialog.show(
      backDismiss: true,
      clickMaskDismiss: true,
      builder: (BuildContext context) {
        return ZoomIn(
          duration: const Duration(milliseconds: 300),
          child: CupertinoAlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/${type.name}.png'),
                  Text(
                    title ??
                        (type == DialogType.error
                            ? 'Xảy ra lỗi'
                            : type == DialogType.warning
                                ? 'Thông báo'
                                : 'Thành công'),
                    style: kStyleBlack20Bold,
                  ),
                  Text(
                    message,
                    style: kStyleBlack16Regular,
                  ),
                ],
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  closeDialog();
                },
              ),
            ],
          ),
        );
      });
}

Future<void> showActionDialog({
  required String message,
  required VoidCallback callback,
  required String action,
  bool? barrierDismissible,
}) async {
  await Asuka.showDialog(
    barrierDismissible: false,
    builder: (context) => ZoomIn(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        title: const Text(
          'Thông báo',
          style: TextStyle(
              color: kRedCentColor, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
          style: kStyleBlack16Regular,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Đóng',
              style: kStyleRed17Bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              callback();
            },
            child: Text(
              action,
              style: kStyleBlue17Bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showExchangeOver({
  required VoidCallback onClose,
  required VoidCallback callback,
  bool? barrierDismissible,
}) async {
  // var custom = Container(
  //   height: 200,
  //   width: MediaQuery.of(context).size.width*.9,
  //   decoration: BoxDecoration(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.circular(5.0),
  //   ),
  //   alignment: Alignment.center,
  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: const <Widget>[
  //       Text(
  //         'Hết lượt nhận quà',
  //         style: TextStyle(
  //             color: kRedCentColor,
  //             fontSize: 18,
  //             fontWeight: FontWeight.w700
  //         ),
  //       )
  //       Text(
  //         'Khách hàng đã nhận tối đa 3 phần quà trong ngày nên không thể tiếp tục nhận thêm quà',
  //         style: kStyleBlack16Regular,
  //       )
  //       LoadingText(
  //         text: 'Đang xử lí',
  //       ),
  //     ],
  //   ),
  // );
  // await SmartDialog.showLoading(
  //   widget: custom,
  //   isLoadingTemp: false,
  //   backDismiss: false,
  // );
  await Asuka.showDialog(
    barrierDismissible: false,
    builder: (context) => ZoomIn(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        title: const Text(
          'Hết lượt nhận quà',
          style: TextStyle(
              color: kRedCentColor, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: const Text(
          'Khách hàng đã nhận tối đa 3 phần quà trong ngày nên không thể tiếp tục nhận thêm quà',
          style: kStyleBlack16Regular,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onClose();
            },
            child: const Text(
              'Đóng',
              style: kStyleRed17Bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              callback();
            },
            child: const Text(
              'Xác nhận và Quay về trang chủ',
              style: kStyleBlue17Bold,
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showSaveSuccess() async {
  await Asuka.showDialog(
    barrierDismissible: true,
    builder: (context) => ZoomIn(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        content: Container(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                  )),
              Center(child: Image.asset('assets/images/success.png')),
              Center(
                  child: Text(
                'Thành công!!!'.toUpperCase(),
                style: kStyleBlack16Bold,
              )),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> showSaveError({required String message}) async {
  await Asuka.showDialog(
    barrierDismissible: false,
    builder: (context) => ZoomIn(
      duration: const Duration(milliseconds: 300),
      child: AlertDialog(
        content: Container(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                  )),
              Center(child: Image.asset('assets/images/error.png')),
              Center(
                  child: Text(
                'Không thành công'.toUpperCase(),
                style: kStyleBlack16Bold,
              )),
              Center(
                  child: Text(
                message,
                style: kStyleGrey14Regular,
              )),
            ],
          ),
        ),
      ),
    ),
  );
}

void showWarning({required String message}) {
  Asuka.showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return ZoomIn(
          duration: const Duration(milliseconds: 100),
          child: CupertinoAlertDialog(
            title: const Text("Thông báo"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: kStyleBlack16Regular,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text("Đóng"),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}

Future<void> displayError(Failure failure) async {
  if (failure is UnAuthenticateFailure) {
    await SmartDialog.show(
        backDismiss: false,
        clickMaskDismiss: false,
        builder: (BuildContext context) {
          return ZoomIn(
            duration: const Duration(milliseconds: 300),
            child: CupertinoAlertDialog(
              title: Text(
                failure.prefix,
                style: kStyleBlack17Bold,
              ),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  failure.message,
                  style: kStyleBlack16Regular,
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    closeDialog();
                    Modular.get<AuthenticationBloc>().add(LoggedOut());
                    Modular.to.canPop() ? Modular.to.pop() : () {};
                  },
                ),
              ],
            ),
          );
        });
    // await Asuka.showDialog(
    //   barrierDismissible: false,
    //   builder: (context) {
    //     return WillPopScope(
    //       onWillPop: () async => false,
    //       child: ZoomIn(
    //         duration: const Duration(milliseconds: 100),
    //         child: AlertDialog(
    //           title: Text(
    //             failure.prefix,
    //             style: kStyleBlack17Bold,
    //           ),
    //           content: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(
    //               failure.message,
    //               style: kStyleBlack16Regular,
    //             ),
    //           ),
    //           actions: [
    //             TextButton(
    //               child: const Text(
    //                 "Xác nhận",
    //                 style: kStyleBlue17Bold,
    //               ),
    //               onPressed: () {
    //                 Modular.get<AuthenticationBloc>().add(LoggedOut());
    //                 Modular.to.canPop() ? Modular.to.pop() : () {};
    //                 Navigator.pop(context);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  } else {
    if (failure is UpdateRequiredFailure) {
      if (AuthenticationBloc.loginEntity != null) {
        Modular.get<AuthenticationBloc>().add(LoggedOut());
      }
      showActionDialog(
        message: failure.message,
        action: 'Cập nhật',
        callback: () {
          Modular.to.pushNamed('/update');
        },
      );
    } else {
      await showMessage(
          type: DialogType.error,
          title: failure.prefix,
          message: failure.message);
    }
  }
}

void showSnackBarMessage(
    {required BuildContext context, required String message}) {
  if (flush != null) {
    flush!.dismiss();
  }
  flush = Flushbar<bool?>(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: kRedCentColor,
      backgroundGradient: LinearGradient(colors: [
        kRedCentColor.withOpacity(0.8),
        kRedCentColor,
        kRedCentColor.withOpacity(0.8)
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
      // titleText: const Text(
      //   'Thông báo',
      //   style: kStyleWhite20Regular,
      // ),
      icon: const Icon(
        IconlyBold.danger,
        size: 30,
        color: kGreenCentColor,
      ),
      mainButton: const Icon(
        IconlyBold.danger,
        size: 30,
        color: kGreenCentColor,
      ),
      // mainButton: InkWell(
      //     onTap: () {
      //       flush!.dismiss();
      //     },
      //     child: const Icon(IconlyLight.closeSquare, size: 30,)),
      duration: const Duration(milliseconds: 3500),
      animationDuration: const Duration(milliseconds: 400),
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0)),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      maxWidth: MediaQuery.of(context).size.width - 60,
      messageText: Center(
        child: Text(
          message,
          style: kStyleWhite17Regular,
        ),
      ))
    ..show(context);
}

void showContentToast(
    {required BuildContext context, required String content, Color? color}) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color ?? Color(0XFFD2F6C8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          content,
          style: kStyleBlack16Medium,
        ),
      ],
    ),
  );
  fToast.removeCustomToast();
  fToast.showToast(
    child: toast,
    fadeDuration: Duration(milliseconds: 200),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 3),
  );
//    return Fluttertoast.showToast(
//      msg: content,
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.BOTTOM,
//      timeInSecForIosWeb: 1,
//      backgroundColor: Colors.black54,
//      textColor: Colors.white,
//      fontSize: 16.0,
//    );
}

Future<void> showLoading() async {
  await SmartDialog.showLoading(
      backDismiss: false,
      clickMaskDismiss: false,
      builder: (_) {
        return CustomLoading();
      });
}

Future<void> closeLoading({String? tag}) async {
  await SmartDialog.dismiss(status: SmartStatus.loading, tag: tag);
}

Future<void> closeDialog({String? tag}) async {
  await SmartDialog.dismiss(status: SmartStatus.dialog, tag: tag);
}

Future<void> showRefreshToast({String? message}) async {
  await SmartDialog.showToast(message ?? 'Dữ liệu đã được làm mới',
      alignment: Alignment.bottomCenter, builder: (_) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(40.0)),
            child: const Text(
              'Dữ liệu đã được làm mới',
              style: kStyleWhite17Regular,
            )),
      ),
    );
  });
}

showHasSync() {
  SmartDialog.show(
      backDismiss: true,
      clickMaskDismiss: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Thoát ứng dụng ?',
            style: kStyleBlack20Bold,
          ),
          content: const Text(
            'Có dữ liệu chưa đồng bộ, bạn có chắc muốn thoát ?',
            style: kStyleBlack17Regular,
          ),
          actions: [
            ElevatedButton(
              onPressed: () => closeDialog(),
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFF1F1F1), elevation: 0),
              child: const Text(
                'Hủy',
                style: kStyleBlack17Regular,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                closeDialog();
                SystemNavigator.pop(animated: true);
                exit(0);
              },
              style:
                  ElevatedButton.styleFrom(primary: kGreenColor, elevation: 0),
              child: const Text(
                'Xác nhận',
                style: kStyleWhite17Regular,
              ),
            ),
          ],
        );
      });
}

showHasSyncLogout() async {
  await SmartDialog.show(
      backDismiss: true,
      clickMaskDismiss: true,
      builder: (BuildContext context) {
        return ZoomIn(
          duration: const Duration(milliseconds: 300),
          child: CupertinoAlertDialog(
            title: const Text(
              'Có dữ liệu chưa đồng bộ',
              style: kStyleBlack20Bold,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Bạn cần đồng bộ trước khi đăng xuất',
                    style: kStyleBlack17Regular,
                  )
                ],
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text("Đóng"),
                onPressed: () {
                  closeDialog();
                },
              ),
            ],
          ),
        );
      });
}

showCloseApp() async {
  await SmartDialog.show(
      backDismiss: true,
      clickMaskDismiss: true,
      builder: (BuildContext context) {
        return ZoomIn(
          duration: const Duration(milliseconds: 300),
          child: CupertinoAlertDialog(
            title: const Text(
              'Thông báo',
              style: kStyleBlack20Bold,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Bạn có chắc muốn tắt ứng dụng ?',
                    style: kStyleBlack17Regular,
                  )
                ],
              ),
            ),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text("Hủy"),
                onPressed: () {
                  closeDialog();
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  closeDialog();
                  // SystemNavigator.pop(animated: true);
                  // exit(0);
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');

                },
                child: const Text(
                  'Xác nhận',
                ),
              ),
            ],
          ),
        );
      });
}

showLogout(LoginBloc bloc) async {
  await SmartDialog.show(
      backDismiss: true,
      clickMaskDismiss: true,
      builder: (BuildContext context) {
        return ZoomIn(
          duration: const Duration(milliseconds: 300),
          child: SimpleDialog(
              title: const Text(
                'Thông báo',
                style: kStyleBlack20Bold,
              ),

              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: const Text(
                    'Bạn có chắc muốn đăng xuất ?',
                    style: kStyleBlack17Regular,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        "Hủy",
                        style: kStyleRed16Regular,
                      ),
                      onPressed: () {
                        closeDialog();
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        closeDialog();
                        bloc.add(Logout());
                      },
                      child: const Text(
                        'Xác nhận',
                      ),
                    ),
                  ],
                )
              ]),
        );
      });
}

void displayMessage({required String message}) {
  showToast(message: message, color: const Color(0XFFFADBDD));
}

void displaySuccess({required String message}) {
  showToast(message: message, color: const Color(0XFFE7F5DD));
}

void displayWarning({required String message}) {
  showToast(message: message, color: const Color(0XFFF8D8D7));
}
