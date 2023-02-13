part of 'validate_bloc.dart';

@immutable
class ValidateState extends Equatable {
  final String name;
  final bool nameValid;
  final String phone;
  final bool phoneValid;
  final String otp;
  final bool otpValid;
  final List<Uint8List> images;
  final bool imagesValid;

  const ValidateState._(
      {required this.nameValid,
      required this.phoneValid,
      required this.otpValid,
      required this.imagesValid,
      required this.name,
      required this.phone,
      required this.otp,
      required this.images});

  ValidateState.init()
      : this._(
            name: '',
            phone: '',
            otp: '',
            images: [],
            nameValid: false,
            phoneValid: false,
            otpValid: false,
            imagesValid: false);

  ValidateState copyWith({String? name,  String? phone, String? otp, List<Uint8List>? images, bool? nameValidate, bool? phoneValidate, bool? otpValidate, bool? imagesValidate}) {
    return ValidateState._(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      images: images ?? this.images,
      nameValid: nameValidate ?? nameValid,
      phoneValid: phoneValidate ?? phoneValid,
      otpValid: otpValidate ?? otpValid,
      imagesValid: imagesValidate ?? imagesValid,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [nameValid, phoneValid, otpValid, imagesValid];
}
