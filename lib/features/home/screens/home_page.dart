import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:nan_aptipro_sampling_2023/core/entity/outlet.dart';
import 'package:nan_aptipro_sampling_2023/core/utils/toats.dart';
import 'package:nan_aptipro_sampling_2023/core/widgets/date_field.dart';
import 'package:nan_aptipro_sampling_2023/features/home/blocs/dashboard_cubit.dart';
import 'package:nan_aptipro_sampling_2023/features/home/blocs/form_cubit.dart';
import 'package:nan_aptipro_sampling_2023/features/home/blocs/validate_bloc.dart';
import 'package:nan_aptipro_sampling_2023/features/home/widgets/take_image.dart';

import '../../../core/common/constants.dart';
import 'package:flutter/material.dart';
import '../../../core/platform/package_info.dart';
import '../../../core/utils/my_dialog.dart';
import '../../login/blocs/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  final bool isEdit;
  final dynamic outletId;
  const HomePage({Key? key, required this.isEdit, required this.outletId})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = AuthenticationBloc.loginEntity!;
  final _formCubit = Modular.get<FormCubit>();
  final _dashboardCubit = Modular.get<DashboardCubit>();
  final _validateBloc = Modular.get<ValidateBloc>();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _otpFocus = FocusNode();

  final _nameCtl =
      kDebugMode ? TextEditingController() : TextEditingController();
  final _phoneCtl = kDebugMode
      ? TextEditingController()
      : TextEditingController();
  final _otpCtl = kDebugMode
      ? TextEditingController()
      : TextEditingController();
  final _dateCtl = TextEditingController();

  DateTime? _selectedDate;
  OutletEntity? outlet;

  final _borderRadius = 8.0;

  late List<Uint8List> _images = [];

  bool isSending = false;

  @override
  void initState() {
    int? id = int.tryParse(widget.outletId);
    if (id != null) {
      _dashboardCubit.getOutlet(id: id);
    } else {
      Modular.to.navigate('/');
    }
    _phoneFocus.addListener(_onFocusChange);
    _otpFocus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _phoneFocus.removeListener(_onFocusChange);
    _phoneFocus.dispose();
    _otpFocus.removeListener(_onFocusChange);
    _otpFocus.dispose();
  }

  void _onFocusChange() {
    if (_phoneFocus.hasFocus) {
      if (_nameCtl.text.isEmpty || _nameCtl.text.replaceAll(' ', '') == '') {
        showToast(message: 'Vui lòng nhập tên khách hàng trước', color: kRedColor);
        FocusScope.of(context).requestFocus(_nameFocus);
        return;
      }
    }
    if (_otpFocus.hasFocus) {
      if (_nameCtl.text.isEmpty || _nameCtl.text.replaceAll(' ', '') == '') {
        showToast(message: 'Vui lòng nhập tên khách hàng trước', color: kRedColor);
        FocusScope.of(context).requestFocus(_nameFocus);
        return;
      }
      if (_phoneCtl.text.isEmpty) {
        showToast(message: 'Vui lòng nhập số điện thoại trước', color: kRedColor);
        FocusScope.of(context).requestFocus(_phoneFocus);
        return;
      }
    }
  }

  void _reset() {
    _validateBloc.add(ResetForm());
    setState(() {
      _nameCtl.clear();
      _phoneCtl.clear();
      _otpCtl.clear();
      _images.clear();
    });
  }

  Widget field(
      {required String label,
      required FocusNode focus,
      FocusNode? nextFocus,
      TextInputType? keyboardType,
      List<TextInputFormatter>? formatter,
        Function(String)? onChanged,
      required bool validated,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            label,
            style: kStyleGrey14Regular,
          ),
        ),
        TextFormField(
          keyboardType: keyboardType,
          inputFormatters: formatter,
          textInputAction:
              nextFocus == null ? TextInputAction.done : TextInputAction.next,
          autofocus: false,
          focusNode: focus,
          onChanged: onChanged,
          onFieldSubmitted: (v) {
            // _validateBloc.add(Validated(
            //     name: _nameCtl.text,
            //     phone: _phoneCtl.text,
            //     otp: _otpCtl.text,
            //     images: _images));
            // if (nextFocus != null) {
            //   FocusScope.of(context).requestFocus(nextFocus);
            // }
          },
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.white.withOpacity(.8),
            suffixIcon: validated
                ? Icon(Icons.check_circle, color: kGreenCentColor)
                : null,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffeaeaea), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              borderSide: BorderSide(color: Color(0xffeaeaea), width: 2),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffeaeaea), width: 2),
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
              gapPadding: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF4F3FD),
        leading: BackButton(
          onPressed: () {
            Modular.to.navigate('/');
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            user.userName,
            style: kStyleBlack16Medium,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Modular.to.pushNamedAndRemoveUntil('/setting', (p0) => false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.settings,
                size: 34,
                color: Colors.grey.shade700,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<DashboardCubit, DashboardState>(
          bloc: _dashboardCubit,
          listener: (context, state) {
            if(state is DashboardFailure){
              displayError(state.failure);
            }
          },
          builder: (context, state) {
            if (state is LoadOutletSuccess) {
              return BlocBuilder<ValidateBloc, ValidateState>(
                bloc: _validateBloc,
                builder: (context, form) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0)),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12.0),
                                  bottomRight: Radius.circular(12.0)),
                              color: Colors.white),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: Image.asset(
                                    'assets/images/outlet.png',
                                    height: 80,
                                  )),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.outlet.name,
                                      style: kStyleBlack16Bold,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Mã outlet: ${state.outlet.code}',
                                      style: kStyleBlack14Regular,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Địa chỉ: ${state.outlet.address}',
                                      style: kStyleBlack14Regular,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Nhập liệu',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                widget.isEdit
                                    ? DateField(
                                        width: MediaQuery.of(context).size.width,
                                        onTap: () async {
                                          // DateTime? pickedDate = await showDatePicker(
                                          //     context: context,
                                          //     initialDate: DateTime.now(),
                                          //     firstDate: DateTime(1950),
                                          //     //DateTime.now() - not to allow to choose before today.
                                          //     lastDate: DateTime(2100));
                                          // if (pickedDate != null) {
                                          //   print(
                                          //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          //   String formattedDate =
                                          //       DateFormat('yyyy-MM-dd').format(pickedDate);
                                          //   print(
                                          //       formattedDate); //formatted date output using intl package =>  2021-03-16
                                          //   setState(() {
                                          //     _dateCtl.text =
                                          //         formattedDate; //set output date to TextField value.
                                          //   });
                                          // } else {}
                                          DateTime? pickedDate =
                                              await showModalBottomSheet<
                                                  DateTime>(
                                            context: context,
                                            builder: (context) {
                                              DateTime? tempPickedDate;
                                              return Container(
                                                height: 250,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          CupertinoButton(
                                                            child: Text(
                                                              'Hủy',
                                                              style:
                                                                  kStyleRed16Regular,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          CupertinoButton(
                                                            child: Text('Xong'),
                                                            onPressed: () {
                                                              if (tempPickedDate ==
                                                                  null) {
                                                                tempPickedDate =
                                                                    _selectedDate ??
                                                                        DateTime
                                                                            .now();
                                                              }
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      tempPickedDate);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 0,
                                                      thickness: 1,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child:
                                                            CupertinoDatePicker(
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .date,
                                                          initialDateTime:
                                                              _selectedDate,
                                                          onDateTimeChanged:
                                                              (DateTime
                                                                  dateTime) {
                                                            tempPickedDate =
                                                                dateTime;
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );

                                          if (pickedDate != null &&
                                              pickedDate != _selectedDate) {
                                            setState(() {
                                              _selectedDate = pickedDate;
                                              String formattedDate =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(pickedDate);
                                              _dateCtl.text = formattedDate;
                                            });
                                          }
                                        },
                                        controller: _dateCtl)
                                    : const SizedBox(),
                                field(
                                    label: 'Tên khách hàng',
                                    onChanged: (value) {
                                      _validateBloc.add(Validated(
                                          name: _nameCtl.text,
                                          phone: _phoneCtl.text,
                                          otp: _otpCtl.text,
                                          images: _images));
                                    },
                                    focus: _nameFocus,
                                    validated: form.nameValid,
                                    formatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.deny(RegExp("[<>%\$]")),
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    nextFocus: _phoneFocus,
                                    controller: _nameCtl),
                                field(
                                    label: 'Số điện thoại',
                                    validated: form.phoneValid,
                                    onChanged: (value) {
                                      if(value.length == 10){
                                        _validateBloc.add(Validated(
                                            name: _nameCtl.text,
                                            phone: _phoneCtl.text,
                                            otp: _otpCtl.text,
                                            images: _images));
                                      }
                                    },
                                    keyboardType: TextInputType.phone,
                                    formatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    focus: _phoneFocus,
                                    nextFocus: _otpFocus,
                                    controller: _phoneCtl),
                                field(
                                    label: 'Mã OTP',
                                    validated: form.otpValid,
                                    onChanged: (value) {
                                      if(value.length == 4){
                                        _validateBloc.add(Validated(
                                            name: _nameCtl.text,
                                            phone: _phoneCtl.text,
                                            otp: _otpCtl.text,
                                            images: _images));
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    formatter: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    focus: _otpFocus,
                                    controller: _otpCtl),
                                TakeImage(
                                  label: 'Hình ảnh',
                                  onTake: (images) {
                                    setState(() {
                                      _images = images;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BlocListener<FormCubit, UploadFormState>(
                        bloc: _formCubit,
                        listener: (context, state) {
                          if (state is FormFailure) {
                            setState(() {
                              isSending = false;
                            });
                            showSaveError(message: state.failure.message);
                          }
                          if (state is FormSuccess) {
                            setState(() {
                              isSending = false;
                            });
                            _reset();
                            showSaveSuccess();
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if(_nameCtl.text.isEmpty || _nameCtl.text.replaceAll(' ', '') == ''){
                              showMessage(
                                  type: DialogType.warning,
                                  message: 'Vui Lòng nhập tên khách hàng');
                              return;
                            }
                            if(!form.nameValid){
                              showMessage(
                                  type: DialogType.warning,
                                  message: 'Tên khách hàng không hợp lệ');
                              return;
                            }
                            if(_phoneCtl.text.isEmpty){
                              showMessage(
                                  type: DialogType.warning,
                                  message: 'Vui Lòng nhập sđt khách hàng');
                              return;
                            }
                            if(_otpCtl.text.isEmpty){
                              showMessage(
                                  type: DialogType.warning,
                                  message: 'Vui Lòng nhập mã OTP');
                              return;
                            }
                            if (_otpCtl.text.length < 4) {
                              showMessage(
                                  type: DialogType.warning,
                                  message: 'Vui Lòng nhập mã OTP 4 số');
                              return;
                            }
                            if (_images.length < 2) {
                              showMessage(
                                  type: DialogType.warning,
                                  message: 'Vui Lòng chụp ít nhất 2 hình');
                              return;
                            }
                            if (!isSending) {
                              setState(() {
                                isSending = true;
                              });
                              _formCubit.sendForm(
                                  outletId: state.outlet.id,
                                  name: _nameCtl.text,
                                  phone: _phoneCtl.text,
                                  otp: _otpCtl.text,
                                  images: _images);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                "Lưu",
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
                        ),
                      ),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Phiên bản ${MyPackageInfo.version}',
                          style: kStyleGrey14Regular,
                        ),
                      )),
                    ],
                  );
                },
              );
            }
            if (state is DashboardFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Lấy thông tin outlet thất bại',
                      style: kStyleGrey16Regular,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _dashboardCubit.getOutlet(
                            id: int.parse(widget.outletId));
                      },
                      child: Text('Tải lại'))
                ],
              );
            }
            return Center(
                child: Image.asset('assets/images/blue_loading.gif',
                    height: 110, width: 110));
          },
        ),
      ),
    );
  }
}
