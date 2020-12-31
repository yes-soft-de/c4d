import 'dart:convert';
import 'package:c4d/utils/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:inject/inject.dart';

@provide
class ApiClient {
  final Dio _client = Dio(BaseOptions());
  final Logger _logger;
  final performanceInterceptor = DioFirebasePerformanceInterceptor();

  final String tag = 'ApiClient';

  ApiClient(this._logger) {
    _client.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    _client.interceptors.add(performanceInterceptor);
  }

  Future<Map<String, dynamic>> get(String url,
      {Map<String, String> queryParams, String token}) async {
    if (token != null){
      print('token :$token');
      _client.options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    _logger.info(tag, 'GET $url');
    try {
      Response  response = await _client.get(
        url,
        queryParameters: queryParams,
        options: buildCacheOptions(Duration(seconds: 15)),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else if (response.statusCode == 404) {
        _logger.warn(tag, 'Get ' + url + '\t' + response.statusCode.toString());
        return null;
      } else {
        _logger.error(
            tag, 'Get ' + url + ' \t ' + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, 'Get ' + url + ' \t ' + e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> delete(String url,
      {Map<String, String> queryParams}) async {
    _logger.info(tag, 'DELETE $url');
    try {
      Response response = await _client.delete(
        url,
        queryParameters: queryParams,
        options: buildCacheOptions(Duration(seconds: 15)),
      );

      if (response.statusCode >= 200 && response.statusCode < 500) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(
            tag, url + response.statusCode.toString() + ' for link ' + url);

        return null;
      }
    } catch (e) {
      _logger.error(tag, url + e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> payLoad,{ String token}) async {
    if (token != null){
      print('token :$token');
      _client.options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      _logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      Response response = await _client.post(url, data: json.encode(payLoad));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag,
            url + response.statusCode.toString() + '\n' + payLoad.toString());
        _logger.error(tag, url + response.data.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, url + e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> put(
      String url, Map<String, dynamic> payLoad) async {
    try {
      _logger.info(tag, 'Requesting Put to: ' + url);
      _logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      var response = await _client.put(url, data: json.encode(payLoad));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _logger.info(tag, response.data.toString());
        return response.data;
      } else {
        _logger.error(tag, url + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      _logger.error(tag, url + e.toString());
      return null;
    }
  }
}
