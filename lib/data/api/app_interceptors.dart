import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  AppInterceptors(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(
            err.requestOptions, err.response?.data['error']['message'] ?? "");

      case DioErrorType.cancel:
        throw RequestCanceledException(err.requestOptions);
      case DioErrorType.unknown:
        throw UnknownException(err.requestOptions);

      case DioErrorType.badCertificate:
        throw BadCertificateException(
            err.requestOptions, err.response?.data['error']['message'] ?? "");
      case DioErrorType.badResponse:
        throw BadRequestException(
            err.requestOptions, err.response?.data['error']['message'] ?? "");
      case DioErrorType.connectionError:
        throw ConnectionException(
            err.requestOptions, err.response?.data['error']['message'] ?? "");
    }
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r, String reason)
      : super(requestOptions: r, message: reason);

  @override
  String toString() {
    return 'Requête invalide.\n$message';
  }
}

class RequestCanceledException extends DioError {
  RequestCanceledException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'La requête est annulée';
  }
}

// class InternalServerErrorException extends DioError {
//   InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Une erreur inconnue s\'est produite, veuillez réessayer plus tard.';
//   }
// }

class BadCertificateException extends DioError {
  BadCertificateException(RequestOptions r, String reason)
      : super(requestOptions: r, message: reason);

  @override
  String toString() {
    return 'votre système d\'exploitation ne prend pas en charge le certificat actuel.\n$message';
  }
}

// class UnauthorizedException extends DioError {
//   UnauthorizedException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Accès refusé.';
//   }
// }

// class NotFoundException extends DioError {
//   NotFoundException(RequestOptions r) : super(requestOptions: r);

//   @override
//   String toString() {
//     return 'Les informations demandées sont introuvables.';
//   }
// }

class ConnectionException extends DioError {
  ConnectionException(RequestOptions r, String reason)
      : super(requestOptions: r, message: reason);

  @override
  String toString() {
    return 'Aucune connexion Internet détectée, veuillez réessayer.\n $message';
  }
}

class UnknownException extends DioError {
  UnknownException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Aucune connexion Internet détectée, veuillez réessayer.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r, String reason)
      : super(requestOptions: r, message: reason);

  @override
  String toString() {
    return 'La connexion a expiré, veuillez réessayer.\n$message';
  }
}
