import 'dart:developer';
import 'dart:io';

import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

enum HttpRequestMethod { get, post, put, delete }

class BaseRestService {
  static int connectTimeout = 10000;
  BaseRestService() {
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      logPrint: log, // specify log function (optional)
      retries: 3, // retry count (optional)
      retryDelays: const [
        // set delays between retries (optional)
        Duration(seconds: 1), // wait 1 sec before first retry
        Duration(seconds: 2), // wait 2 sec before second retry
        Duration(seconds: 3), // wait 3 sec before third retry
      ],
    ));
    _dio.interceptors.add(
      PrettyDioLogger(
        // requestHeader: true,
        queryParameters: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        showProcessingTime: true,
        showCUrl: true,
        canShowLog: false,
      ),
    );
  }
  static final _dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: connectTimeout),
      receiveTimeout: Duration(seconds: connectTimeout),
    ),
  );
  static const String urlSeparator = '/';

  Future<T?> sendHttpRequest<T>({
    bool requiresAccessToken = true,
    bool requiresLongTimeOut = false,
    required String? accessToken,
    String fullUrl = '',
    String baseUrl = '',
    String controller = '',
    String endPoint = '',
    required HttpRequestMethod httpRequestMethod,
    dynamic requestBody,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Map<String, String>? additionalRequestHeaders,
  }) async {
    //Throw exception if access token is required but not provided
    if (requiresAccessToken && accessToken == null) {
      log('Access token is required but not provided');
      throw UnauthorisedException();
    }

    //Set default parameter values
    if (fullUrl == '') {
      baseUrl = baseUrl != ''
          ? baseUrl
          : RestServiceConstants.devappsUrl + urlSeparator;
      controller =
          controller != '' ? controller : ApiContrtollers.app + urlSeparator;
      fullUrl = baseUrl + controller + endPoint;
    }
    contentType = contentType ?? 'application/json; charset=utf-8';

    //Set Request Headers
    Map<String, String> requestHeaders = <String, String>{};
    if (requiresAccessToken) {
      requestHeaders = {'Authorization': 'Bearer $accessToken'};
    }
    if (additionalRequestHeaders != null) {
      requestHeaders.addAll(additionalRequestHeaders);
    }

    //Set options
    var options = Options();
    options.method = httpRequestMethod.name.toUpperCase();
    options.contentType = contentType;
    if (requestHeaders.isNotEmpty) {
      options.headers = requestHeaders;
    }

    if (requiresLongTimeOut) {
      options.sendTimeout =  const Duration(seconds: 30000);
      options.receiveTimeout = const Duration(seconds: 30000);
    }

    //Call api
    final response = await _dio.request(
      fullUrl,
      data: requestBody,
      queryParameters: queryParameters,
      options: options,
    );

    

    if (response.statusCode == 200) {
      //Success
      return response.data;
    }

    //The API has returned 401 meaning that the user is unauthorised
    //Check validity for access token and if invalid request the user to relogin
    if (response.statusCode == 401) {
      throw UnauthorisedException();
    }
    throw HttpStatusCodeErrorException();
  }

  dynamic sendFileHttpRequest({
    bool requiresAccessToken = true,
    bool requiresLongTimeOut = false,
    required String? accessToken,
    String baseUrl = '',
    String controller = '',
    required String endPoint,
    required HttpRequestMethod httpRequestMethod,
    required File file,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    Map<String, String>? additionalRequestHeaders,
  }) async {
    //Throw exception if access token is required but not provided
    if (requiresAccessToken && accessToken == null) {
      log('Access token is required but not provided');
      throw UnauthorisedException();
    }

    //Set default parameter values
    baseUrl = baseUrl != ''
        ? baseUrl
        : RestServiceConstants.devappsUrl + urlSeparator;
    controller =
        controller != '' ? controller : ApiContrtollers.app + urlSeparator;
    contentType = contentType ?? 'application/json; charset=utf-8';

    //Set Request Headers
    Map<String, String> requestHeaders = <String, String>{};
    if (requiresAccessToken) {
      requestHeaders = {'Authorization': 'Bearer $accessToken'};
    }
    if (additionalRequestHeaders != null) {
      requestHeaders.addAll(additionalRequestHeaders);
    }

    //Set options
    String url = baseUrl + controller + endPoint;
    var options = Options();
    options.method = httpRequestMethod.name.toUpperCase();
    options.contentType = contentType;
    if (requestHeaders.isNotEmpty) {
      options.headers = requestHeaders;
    }

    if (requiresLongTimeOut) {
      options.sendTimeout = const Duration(seconds: 30000);
      options.receiveTimeout = const Duration(seconds: 30000);
    }

    //Call api
    final response = await _dio.request(
      url,
      data: Stream.fromIterable([file.readAsBytesSync()]),
      queryParameters: queryParameters,
      options: options,
    );

    if (response.statusCode == 200) {
      //Success
      return response.data;
    }

    //The API has returned 401 meaning that the user is unauthorised
    //Check validity for access token and if invalid request the user to relogin
    if (response.statusCode == 401) {
      throw UnauthorisedException();
    }
    throw HttpStatusCodeErrorException();
  }
}
