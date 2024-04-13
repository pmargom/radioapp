import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_mappings.dart';
import 'interceptors.dart';

class ServicesBaseApi {
  Dio dio = Dio();

  ServicesBaseApi() {
    dio.interceptors.add(AppInterceptors());

    // http options
    dio.options.baseUrl = ApiMappings.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    // dio.options.connectTimeout = 10000;
    // dio.options.receiveTimeout = 10000;
  }

  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<Response?> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(url, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
