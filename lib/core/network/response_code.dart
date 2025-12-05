enum ResponseCode {
  success,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  internalServerError,
  serviceUnavailable,
  gatewayTimeout,
  isNull,
  unknown,
}

extension ResponseCodeX on ResponseCode {
  int get value {
    switch (this) {
      case ResponseCode.success:
        return 200;
      case ResponseCode.badRequest:
        return 400;
      case ResponseCode.unauthorized:
        return 401;
      case ResponseCode.forbidden:
        return 403;
      case ResponseCode.notFound:
        return 404;
      case ResponseCode.conflict:
        return 409;
      case ResponseCode.internalServerError:
        return 500;
      case ResponseCode.serviceUnavailable:
        return 503;
      case ResponseCode.gatewayTimeout:
        return 504;
      case ResponseCode.isNull:
        return 9001;
      case ResponseCode.unknown:
        return -1;
    }
  }

  static ResponseCode from(int? code) {
    switch (code) {
      case 200:
        return ResponseCode.success;
      case 400:
        return ResponseCode.badRequest;
      case 401:
        return ResponseCode.unauthorized;
      case 403:
        return ResponseCode.forbidden;
      case 404:
        return ResponseCode.notFound;
      case 409:
        return ResponseCode.conflict;
      case 500:
        return ResponseCode.internalServerError;
      case 503:
        return ResponseCode.serviceUnavailable;
      case 504:
        return ResponseCode.gatewayTimeout;
      case 9001:
        return ResponseCode.isNull;
      default:
        return ResponseCode.unknown;
    }
  }

  String get description {
    switch (this) {
      case ResponseCode.success:
        return "Success";
      case ResponseCode.badRequest:
        return "Bad Request";
      case ResponseCode.unauthorized:
        return "Unauthorized";
      case ResponseCode.forbidden:
        return "Forbidden";
      case ResponseCode.notFound:
        return "Not Found";
      case ResponseCode.conflict:
        return "Conflict";
      case ResponseCode.internalServerError:
        return "Internal Server Error";
      case ResponseCode.serviceUnavailable:
        return "Service Unavailable";
      case ResponseCode.gatewayTimeout:
        return "Gateway Timeout";
      case ResponseCode.isNull:
        return "Data isNull";
      case ResponseCode.unknown:
        return "Unknown Error";
    }
  }
}
