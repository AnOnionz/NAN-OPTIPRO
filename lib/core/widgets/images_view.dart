import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../core/widgets/preview_image_dialog.dart';
import 'package:photo_view/photo_view.dart';

class InternetImageView extends StatelessWidget {
  final List<String> images;
  const InternetImageView({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void previewImage({File? file, Widget? imageNetwork}) async {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          if (imageNetwork == null) {
            return PreviewImageDialog(
              image: file,
            );
          }
          return PreviewImageDialog(
            imageNetwork: imageNetwork,
          );
        },
      );
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: images.map((image) {
                final _imageNetwork = CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) =>
                      PhotoView(
                        imageProvider: imageProvider,
                      ),
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                      Container(
                        child: CupertinoActivityIndicator(),
                      ),
                  errorWidget: (context, url, error) {
                    print(error);
                    return Icon(IconlyLight.image2);
                  },
                );
                return GestureDetector(
                  onTap: () {
                    previewImage(imageNetwork: _imageNetwork);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: images.indexOf(image) ==
                        images.length - 1
                        ? const EdgeInsets.only(right: 0)
                        : const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5)),
                      child: _imageNetwork,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
