import 'dart:developer';
import 'dart:io';

import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

class ExcepetionHandler {
  static CCError handleException({required Exception exception}) {
    log("Handling exception: $exception", name: "ExceptionHandler");
    if (exception is DioException) {
      return _dioExceptionHandler(dioError: exception);
    }
    if (exception is UnauthorisedException) {
      return CCError.unauthorisedError;
    } else if (exception is SocketException) {
      return CCError.noConnectivityError;
    } else if (exception is ServerException) {
      return const CCError();
    } else {
      return const CCError();
    }
  }

  static CCError _dioExceptionHandler({required DioException dioError}) {
    if (dioError is SocketException) {
      return CCError.noConnectivityError;
    } else if (dioError.type == DioExceptionType.badResponse &&
        dioError.response?.statusCode == 401) {
      return CCError.unauthorisedError;
    } else {
      return const CCError();
    }
  }
}
