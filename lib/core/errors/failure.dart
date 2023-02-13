import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message ;
  final String prefix;
  const Failure(this.prefix, this.message);

  @override
  String toString() {
    return message;
  }
  @override
  List<Object> get props => [message];
}
class InternalFailure extends Failure{
  const InternalFailure(): super("Đã xảy ra lỗi ngoài ý muốn", 'Vui lòng thử lại sau');
}
class UnAuthenticateFailure extends Failure{
  const UnAuthenticateFailure(): super("Thông báo", 'Tài khoản đã truy cập trên thiết bị khác');
}
class UpdateRequiredFailure extends Failure{
  const UpdateRequiredFailure({message}): super("Thông báo", message);
}
class ApiNotRespondingFailure extends Failure{
  const ApiNotRespondingFailure({message}): super('Kết nối mạng không ổn định', 'Vui lòng kiểm tra kết nối mạng và thử lại');
}
class FetchDataFailure extends Failure{
  const FetchDataFailure({message}): super('Lấy dữ liệu thất bại', message);
}
class InternetFailure extends Failure{
  const InternetFailure() : super("Kết nối mạng không ổn định", 'Vui lòng kiểm tra kết nối mạng và thử lại');
}
class OfflineFailure extends Failure{
  const OfflineFailure() : super("Thông báo", 'Dữ liệu đã được lưu vào đồng bộ');
}
class BadRequestFailure extends Failure{
  const BadRequestFailure({message,}) : super('Thông báo', message);
}
class SpecialFailure extends Failure{
  const SpecialFailure({message}) : super('Thông báo', message);
}


