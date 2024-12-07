import 'package:dio/dio.dart';
import 'package:orange_bay/core/utils/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio {
  static Dio? _dio;

  static Dio _instance() {
    return _dio ??= Dio(
      BaseOptions(
        baseUrl: PreferenceUtils.getString(
          PrefKeys.baseUrl,
          "http://elgzeraapp.runasp.net/api/",
        ),
      ),
    );
  }

  static void init() {
    _dio = _instance();
    addInterceptors();
  }

  static void addInterceptors() {
    _dio!.interceptors.add(PrettyDioLogger(
      responseHeader: true,
      responseBody: true,
      requestHeader: true,
      requestBody: true,
    ));
  }

  static Future<Response<dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio!.get(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${PreferenceUtils.getString(PrefKeys.accessToken)}'
        },
      ),
    );
  }

  static Future<Response<dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) {
    return _dio!.post(
      endPoint,
      queryParameters: queryParameters,
      data: body,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${PreferenceUtils.getString(PrefKeys.accessToken)}'
        },
      ),
    );
  }

  static Future<Response<dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) {
    return _dio!.put(
      endPoint,
      queryParameters: queryParameters,
      data: body,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${PreferenceUtils.getString(PrefKeys.accessToken)}'
        },
      ),
    );
  }

  static Future<Response<dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) {
    return _dio!.delete(
      endPoint,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${PreferenceUtils.getString(PrefKeys.accessToken)}'
        },
      ),
    );
  }

  static void setBaseUrl(String baseUrl) {
    _dio!.options.baseUrl = baseUrl;
  }
}
