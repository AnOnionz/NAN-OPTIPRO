import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/common/constants.dart';
import '../../../core/platform/package_info.dart';
import '../../../core/utils/my_dialog.dart';
import '../../login/blocs/authentication_bloc.dart';
import '../../login/blocs/login_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final user = AuthenticationBloc.loginEntity!;
  final _bloc = Modular.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF4F3FD),
        title: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            user.userName,
            style: kStyleBlack16Medium,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Cài đặt',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      "Ứng dụng",
                      style: kStyleBlack16Regular,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      MyPackageInfo.appName,
                      style: kStyleBlack16Regular,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      "Phiên bản",
                      style: kStyleBlack16Regular,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      MyPackageInfo.version,
                      style: kStyleBlack16Regular,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      "Thiết kế",
                      style: kStyleBlack16Regular,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'IMARK',
                      style: kStyleBlack16Regular,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                bloc: _bloc,
                builder: (context, state) {
                  if (state is LogoutLoading) {
                    return Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kRedColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Center(
                        child: CupertinoActivityIndicator(
                          radius: 10,
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () async {
                      await showLogout(_bloc);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kRedColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Đăng xuất",
                          style: kStyleWhite20Medium,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
