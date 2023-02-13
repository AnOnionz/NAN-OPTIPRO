import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class PreviewImageDialog extends StatefulWidget {
  File? image;
  Widget? imageNetwork;
  final VoidCallback? onTap;
  final String? textButton;

  PreviewImageDialog(
      {Key? key, this.image, this.onTap, this.textButton, this.imageNetwork})
      : super(key: key);

  @override
  _PreviewImageDialogState createState() => _PreviewImageDialogState();
}

class _PreviewImageDialogState extends State<PreviewImageDialog> {
  File? get _image => widget.image;
  VoidCallback? get _event => widget.onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Container(
          height: 350,
          child: widget.imageNetwork ??
              PhotoView(imageProvider: FileImage(_image!))),
      actions: widget.textButton != null
          ? [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text(widget.textButton!),
                onPressed: _event,
              ),
              CupertinoDialogAction(
                child: const Text("Đóng"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ]
          : [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text("Đóng"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
    );
    // SimpleDialog(
    //   contentPadding: const EdgeInsets.all(5),
    //   children: <Widget>[
    //     widget.imageNetwork ??
    //         Image.file(

    //           _image!,
    //           height: MediaQuery.of(context).size.height * .8,
    //           fit: BoxFit.cover,
    //         ),
    //     Row(
    //       children: <Widget>[
    //         widget.textButton != null
    //             ? TextButton(
    //                 child: Text(
    //                   widget.textButton!,
    //                   style: const TextStyle(
    //                       fontSize: 16, color: Colors.redAccent),
    //                 ),
    //                 onPressed: _event,
    //               )
    //             : const SizedBox(),
    //         const Spacer(),
    //         TextButton(
    //           child: const Text(
    //             'Đóng',
    //             style: TextStyle(
    //               fontSize: 16,
    //             ),
    //           ),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
