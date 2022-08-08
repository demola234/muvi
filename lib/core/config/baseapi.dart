// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseApi {
  late Dio dio;

  BaseApi() {
    final options = BaseOptions(
        baseUrl: 'BASE_URL',
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 60 * 1000, // 60 seconds
        );
    dio = Dio(options);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  Future<Map<String, dynamic>> get(
    path, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> query = const {},
  }) =>
      makeRequest(
        dio.get(
          '/$path',
          queryParameters: query,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> post(path,
      {Map<String, dynamic>? data,
      Map<String, dynamic> headers = const {},
      FormData? formData}) {
    if (formData != null) {
      headers.addAll({
        'ContentType': 'multipart/form-data',
        'content-type': 'multipart/form-data'
      });
    }
    return makeRequest(
      dio.post(
        '/$path',
        data: formData ?? data,
        options: Options(
          headers: {
            ...headers, // set content-length
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> patch(path,
          {Map<String, dynamic>? data,
          Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.patch(
          '/$path',
          data: data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> put(path,
          {Map<String, dynamic>? data,
          Map<String, dynamic> headers = const {},
          FormData? formData}) =>
      makeRequest(
        dio.put(
          '/$path',
          data: formData ?? data,
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> delete(path,
          {Map<String, dynamic> headers = const {}}) =>
      makeRequest(
        dio.delete(
          '/$path',
          options: Options(
            headers: {
              ...headers, // set content-length
            },
          ),
        ),
      );

  Future<Map<String, dynamic>> makeRequest(Future<Response> future) async {
    try {
      var req = await future;

      var data = req.data;
      if (req.statusCode == HttpStatus.unauthorized || data['error'] != null) {
        QueuedInterceptor();
      }

      if ('${req.statusCode}'.startsWith('2') ||
          (data['success'] != null && data['success'])) {
        if (!(data is Map)) {
          return <String, dynamic>{'data': data};
        }
        return data as Map<String, dynamic>;
      }
      if (data['error'] != null) {
        throw Exception(data['error']);
      }

      throw Exception(data['message']);
    } on DioError catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        QueuedInterceptor();
      }
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.other) {
        throw RequestException('Connection  Timeout Exception');
      }
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      parseMapOrList(var data) {
        if (data is Map) {
          throw RequestException(parseErrorMessage(data));
        }

        if (data is List) {
          final first = data.first;

          if (first is Map) {
            throw RequestException(parseErrorMessage(first));
          } else {
            throw RequestException('$first');
          }
        }
        throw RequestException(data);
      }

      if (e.response != null) {
        if (e.response?.data != null && e.response!.data is Map) {
          if (e.response!.data['message'] != null) {
            throw RequestException(e.response!.data['message']);
          } else if (e.response!.data['error'] != null) {
            parseMapOrList(e.response!.data['error']);
          } else if (e.response!.data['errors'] != null) {
            parseMapOrList(e.response!.data['errors']);
          }
        }
        throw RequestException(e.response?.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        throw RequestException(e.message);
      }
    } catch (err) {
      if (err is DioError) {
        throw Exception(err.message);
      } else {
        throw Exception(getErrorMessage(err));
      }
    }
  }

  dynamic getErrorMessage(err) {
    if (err != null && err.name != null && '${err.name}'.isNotEmpty) {
      return err.name;
    }
    return 'Unknown error';
  }

  dynamic parseErrorMessage(Map<dynamic, dynamic>? err) {
    if (err != null) {
      if (err['message'] != null) {
        return err['message'];
      }

      if (err['error'] != null) {
        return err['error'];
      }

      if (err['errors'] != null) {
        if (err['errors'] is Map) {
          var values = (err['errors'] as Map).values;
          return values.join(', ');
        }
        return err['errors'];
      }

      return err.values.toList().join(', ');
    }
    return 'Unknown error';
  }

  Map<String, dynamic> getHeader(token) {
    return {'Authorization': 'Bearer $token'};
  }
}

class RequestException implements Exception {
  final String message;
  RequestException(
      [this.message = 'Ops, we are sorry. Please, try to update your app...']);
}
