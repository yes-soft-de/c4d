import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:c4d/utils/logger/logger.dart';

@provide
class ApiClient {
  String token;
  final Logger _logger;
  final String tag = 'ApiClient';

  ApiClient(this._logger);

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting GET to: ' + url);
      _logger.info(tag, 'Headers: ' + headers.toString());
      _logger.info(tag, 'Query: ' + queryParams.toString());
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      var response = await client.get(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      _logger.error(tag, e.toString() + ' ' + url);
      return null;
    }
  }

  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    Dio client = Dio(BaseOptions(
      sendTimeout: 60000,
      receiveTimeout: 60000,
      connectTimeout: 60000,
    ));
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      _logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      _logger.info(tag, 'Headers: ' + jsonEncode(headers));
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      var response = await client.post(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
      );
      return _processResponse(response);
    } catch (e) {
      _logger.error(tag, e.toString() + url);
      return null;
    }
  }

  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting PUT to: ' + url);
      _logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));
      var response = await client.put(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
      );
      return _processResponse(response);
    } catch (e) {
      _logger.error(tag, e.toString() + url);
      return null;
    }
  }

  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, String> queryParams,
    Map<String, String> headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting DELETE to: ' + url);
      _logger.info(tag, 'Headers: ' + headers.toString());
      _logger.info(tag, 'Query: ' + queryParams.toString());
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      var response = await client.delete(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      _logger.error(tag, e.toString() + ' ' + url);
      return null;
    }
  }

  Map<String, dynamic> _processResponse(Response response) {
    if (response.statusCode >= 200 && response.statusCode < 400) {
      _logger.info(tag, response.data.toString());
      return response.data;
    } else {
      _logger.error(tag, response.statusCode.toString());
      return null;
    }
  }
}
