import 'dart:html';

import 'package:asuka/asuka.dart';
import 'package:nan_aptipro_sampling_2023/core/common/constants.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakeImage extends StatefulWidget {
  final Function(List<Uint8List> images) onTake;
  final String label;

  const TakeImage({Key? key, required this.onTake, required this.label})
      : super(key: key);
  @override
  _TakeImageState createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  late List<Uint8List> images = [];

  final _picker = ImagePicker();

  static Future<ui.Image> bytesToImage(Uint8List imgBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  String getOSInsideWeb() {
    final userAgent = window.navigator.userAgent.toString().toLowerCase();
    if( userAgent.contains("iphone"))  return "Ios";
    if( userAgent.contains("ipad")) return "Ios";
    if( userAgent.contains("android"))  return "Android";
    return "Web";
  }

  void takePic() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 720,
        maxWidth: 1280,
        imageQuality: getOSInsideWeb() == 'Ios' ? 45 : 80,

    );
    if (pickedFile != null) {
      //final bytes = await pickedFile.readAsBytes();
      final file = await pickedFile.readAsBytes();
      images.add(file);
      widget.onTake(images);
      setState(() {});
    }
  }

  void replacePic(Uint8List image) async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 720,
        maxWidth: 1280,
        imageQuality: getOSInsideWeb() == 'Ios' ? 45 : 80,
    );
    if (pickedFile != null) {
      //final bytes = await pickedFile.readAsBytes();
      final file = await pickedFile.readAsBytes();
      images.remove(image);
      images.add(file);
      widget.onTake(images);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                widget.label,
                style: kStyleGrey14Regular,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () async {
                      images.length < 3 ? takePic() : (_) {};
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.grey.shade800,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                for (var image in images) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        Asuka.showDialog(
                          barrierDismissible: true,
                          builder: (context) {
                            return SimpleDialog(
                              children: [
                                Container(
                                  width: size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InteractiveViewer(
                                            child: Image.memory(image)),
                                      )),
                                      Flexible(
                                        child: Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      replacePic(image);
                                                    },
                                                    child: Text(
                                                      'Chụp lại',
                                                      style: kStyleBlue17Bold,
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Đóng',
                                                      style: kStyleRed17Bold,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: MemoryImage(image)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
