import 'package:flutter/material.dart';
import '../../../core/common/constants.dart';
import '../../../core/utils/my_dialog.dart';

class RefreshModal extends StatefulWidget {
  final VoidCallback onPressed;
  const RefreshModal({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<RefreshModal> createState() => _RefreshModalState();
}

class _RefreshModalState extends State<RefreshModal> {
  bool confirm = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Làm mới dữ liệu',
                style: kStyleBlack20Bold,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Bạn có muốn cập nhật dữ liệu ?',
                style: kStyleBlack17Regular,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        actions: [
          ElevatedButton(
            onPressed: () {
              closeDialog(tag: 'refresh_modal');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF1F1F1), elevation: 0),
            child: const Text(
              'Đóng',
              style: kStyleBlack17Regular,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              closeDialog(tag: 'refresh_modal');
              widget.onPressed();
            },
            style: ElevatedButton.styleFrom(
                primary: kGreenColor, elevation: 0),
            child: const Text(
              'Làm mới',
              style: kStyleWhite17Regular,
            ),
          ),
        ],
      ),
    );
  }
}
