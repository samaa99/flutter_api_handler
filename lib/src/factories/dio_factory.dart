import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Configuration options for DioFactory
class DioConfig {
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final bool enableLogging;
  final bool requestHeader;
  final bool requestBody;
  final bool responseBody;
  final bool responseHeader;

  const DioConfig({
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.enableLogging = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseBody = true,
    this.responseHeader = false,
  });
}

class DioFactory {
  static Dio? _dio;

  /// Create or return existing Dio instance with optional configuration
  static Dio createDio([DioConfig? config]) {
    final dioConfig = config ?? const DioConfig();

    if (_dio == null) {
      _dio = Dio();
      _dio!
        ..options.connectTimeout = dioConfig.connectTimeout
        ..options.receiveTimeout = dioConfig.receiveTimeout;
      
      if (dioConfig.enableLogging) {
        _addDioInterceptors(dioConfig);
      }

      return _dio!;
    } else {
      return _dio!;
    }
  }

  /// Reset the Dio instance (useful for testing)
  static void reset() {
    _dio = null;
  }

  static void _addDioInterceptors(DioConfig config) {
    _dio?.interceptors.add(
      PrettyDioLogger(
        requestHeader: config.requestHeader,
        requestBody: config.requestBody,
        responseBody: config.responseBody,
        responseHeader: config.responseHeader,
        enabled: kDebugMode,
      ),
    );
  }
}