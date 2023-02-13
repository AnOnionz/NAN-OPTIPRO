import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/utils/my_dialog.dart';
import '../../../core/common/constants.dart';
import '../../../core/widgets/password_field.dart';
import '../blocs/change_pass_cubit.dart';

class ChangePassPage extends StatefulWidget {
  ChangePassPage({Key? key}) : super(key: key);

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {

  final _cubit = Modular.get<ChangePassCubit>();


  final TextEditingController _oldPassCtrl = TextEditingController();
  final TextEditingController _newPassCtrl = TextEditingController();
  final TextEditingController _reNewPassCtrl = TextEditingController();
  FocusNode _oldFocus = FocusNode();
  FocusNode _newFocus = FocusNode();
  FocusNode _reNewFocus = FocusNode();

  @override
  void dispose() {
    _cubit.close();
    _oldPassCtrl.dispose();
    _newPassCtrl.dispose();
    _reNewPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        color: Color(0xffEBEBEB),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    'Đổi mật khẩu',
                    style: kStyleBlack25Bold,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    PasswordField(
                      label: 'Mật khẩu cũ',
                      controller: _oldPassCtrl,
                      focusNode: _oldFocus,
                    ),
                    PasswordField(
                      label: 'Mật khẩu mới',
                      controller: _newPassCtrl,
                      focusNode: _newFocus,
                    ),
                    PasswordField(
                      label: 'Nhập lại mật khẩu mới',
                      controller: _reNewPassCtrl,
                      focusNode: _reNewFocus,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocConsumer<ChangePassCubit, ChangePassState>(
                      bloc: _cubit,
                      listener: (context, state) {
                        if(state is ChangePassLoading){
                          showLoading();
                        }
                        if(state is ChangePassFailure){
                          closeLoading();
                          displayError(state.failure);
                        }
                        if(state is ChangePassSuccess){
                          closeLoading();
                          showMessage(type: DialogType.success, message: 'Mật khẩu của bạn đã được thay đổi');
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_oldPassCtrl.text.isEmpty) {
                                  showMessage(
                                      type: DialogType.warning,
                                      title: 'Mật khẩu cũ không được để trống',
                                      message: 'Vui lòng nhập lại');
                                  return;
                                }
                                if (_newPassCtrl.text.isEmpty) {
                                  showMessage(
                                      type: DialogType.warning,
                                      title: 'Mật khẩu mới không được để trống',
                                      message: 'Vui lòng nhập lại');
                                  return;
                                }
                                if (_reNewPassCtrl.text.isEmpty) {
                                  showMessage(
                                      type: DialogType.warning,
                                      title: 'Nhập lại mật khẩu mới không được để trống',
                                      message: 'Vui lòng nhập lại');
                                  return;
                                }
                                if (_newPassCtrl.text != _reNewPassCtrl.text) {
                                  showMessage(
                                      type: DialogType.warning,
                                      title: 'Mật khẩu mới không khớp',
                                      message: 'Vui lòng nhập lại');
                                  return;
                                }
                                _cubit.changePass(oldPass: _oldPassCtrl.text, newPass: _newPassCtrl.text);
                              },
                              child: Text('Đổi mật khẩu')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
