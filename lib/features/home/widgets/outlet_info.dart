import 'package:flutter/material.dart';
import '../../../core/common/constants.dart';
import '../../../features/login/blocs/authentication_bloc.dart';

class OutletInfo extends StatelessWidget {
  const OutletInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthenticationBloc.loginEntity;
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Trang chủ', style: kStyleBlack25Bold,),
          Text(user!.name, style: kStyleBlack16Regular,),
        ],
      ),
    );
  }
}
