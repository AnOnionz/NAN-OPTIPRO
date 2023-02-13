import 'dart:io';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nan_aptipro_sampling_2023/core/platform/package_info.dart';

import '../../../core/utils/toats.dart';
import '../../../core/common/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/login/blocs/login_bloc.dart';

class LoginPage extends StatefulWidget {
  final String deviceId;
  const LoginPage({Key? key, required this.deviceId}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc = Modular.get<LoginBloc>();
  TextEditingController ctlUserName = !kDebugMode
      ? TextEditingController()
      : TextEditingController(text: 'user');
  TextEditingController passWordController = !kDebugMode
      ? TextEditingController()
      : TextEditingController(text: '123456');
  bool _obscureText = true;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  bool resizeBottom = false;

  static const _borderRadius = 12.0;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _nameFocusNode.addListener(_setResizeScaffold);
    _passFocusNode.addListener(_setResizeScaffold);
    super.didChangeDependencies();
  }

  void _setResizeScaffold() {
    setState(() {
      resizeBottom = _nameFocusNode.hasFocus || _passFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(_setResizeScaffold);
    _nameFocusNode.dispose();
    _passFocusNode.removeListener(_setResizeScaffold);
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        exit(0);
      },
      child: GestureDetector(
        onTap: () {
          _nameFocusNode.unfocus();
          _passFocusNode.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 278,
              ),
              Expanded(
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Đăng nhập',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Tài khoản',
                                style: kStyleGrey14Regular,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                autofocus: false,
                                focusNode: _nameFocusNode,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(_passFocusNode);
                                },
                                controller: ctlUserName,
                                decoration: InputDecoration(
                                  hintText: 'Tài khoản',
                                  hintStyle: kStyleBlack16Regular,
                                  contentPadding: EdgeInsets.all(16),
                                  // prefixIcon:
                                  //     Image.asset('assets/images/user.png'),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(.8),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeaeaea), width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_borderRadius)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_borderRadius)),
                                    borderSide: BorderSide(
                                        color: Color(0xffeaeaea), width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeaeaea), width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_borderRadius)),
                                    gapPadding: double.infinity,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Mật khẩu',
                                style: kStyleGrey14Regular,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                focusNode: _passFocusNode,
                                textInputAction: TextInputAction.done,
                                obscureText: _obscureText,
                                obscuringCharacter: "•",
                                controller: passWordController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Mật khẩu',
                                  hintStyle: kStyleBlack16Regular,
                                  // prefixIcon:
                                  //     Image.asset('assets/images/padlock.png'),
                                  contentPadding: const EdgeInsets.all(16),
                                  suffixIcon: InkWell(
                                    onTap: _toggle,
                                    child: _obscureText
                                        ? Image.asset(
                                            'assets/images/eye.png',
                                            width: 24,
                                          )
                                        : Image.asset(
                                            'assets/images/eye1.png',
                                            width: 24,
                                          ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(.8),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeaeaea), width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_borderRadius)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeaeaea), width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_borderRadius)),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeaeaea), width: 2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_borderRadius)),
                                    gapPadding: double.infinity,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              _nameFocusNode.unfocus();
                              _passFocusNode.unfocus();
                              if (ctlUserName.text.isEmpty ||
                                  passWordController.text.isEmpty) {
                                showToast(
                                    message:
                                        'Tài khoản và mật khẩu không được để trống',
                                    color: kRedOpacityColor);
                                return;
                              }
                              bloc.add(Login(
                                  userName: ctlUserName.text,
                                  password: passWordController.text,
                                  deviceId: widget.deviceId));
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                "Đăng nhập",
                                style: kStyleWhite20Medium,
                              )),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(_borderRadius),
                                color: kBlueColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                              child: Text(
                            'Phiên bản ${MyPackageInfo.version}',
                            style: kStyleGrey14Regular,
                          )),
                          const Spacer(
                            flex: 3,
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            // decoration: BoxDecoration(
                            //   color: Colors.white.withOpacity(0.8),
                            // ),
                            child: Center(
                              child: Text(
                                "Design by Imark",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Helvetica-regular',
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
