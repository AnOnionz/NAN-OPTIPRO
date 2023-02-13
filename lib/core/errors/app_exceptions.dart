class AppException implements Exception {
  final String message;
  final String prefix;
  final String? url;

  AppException({required this.message,required this.prefix, this.url});

}

class BadRequestException extends AppException {
  BadRequestException({required String message, String? url, int? code}) : super(message: message, prefix: code?.toString() ?? "Bad Request", url: url);

  @override
  String toString() {
    return 'BadRequestException{message: $message, url: $url}';
  }
}
class InternetException extends AppException {
  InternetException({required String message, String? url}) : super(message: message, prefix: "Không có kết nối mạng", url: url);
  @override
  String toString() {
    return 'InternetException{message: $message, url: $url}';
  }
}

class InternalException extends AppException {
  InternalException({required String message, String? url}) : super(message: message, prefix: "Máy chủ gặp sự cố", url : url);
  @override
  String toString() {
    return 'InternalException{message: $message, url: $url}';
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String message, String? url}) : super(message: message, prefix: "Không có quyền truy cập", url: url);
  @override
  String toString() {
    return 'FetchDataException{message: $message, url: $url}';
  }
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException({required String message, String? url}) : super(message: message, prefix: "Kết nối mạng không ổn định", url: url);
  @override
  String toString() {
    return 'ApiNotRespondingException{message: $message, url: $url}';
  }
}
class UnAuthorizedException extends AppException {
  UnAuthorizedException({required String message, String? url}) : super(message: message, prefix: "Phiên đang nhập đã hết hạn", url: url);
  @override
  String toString() {
    return 'UnAuthorizedException{message: $message, url: $url}';
  }
}
class UpdateRequiredException extends AppException {
  UpdateRequiredException({required String message, String? url}) : super(message: message, prefix: "Phiên bản của bạn đã cũ", url: url);
  @override
  String toString() {
    return 'UpdateRequiredException{message: $message, url: $url}';
  }
}