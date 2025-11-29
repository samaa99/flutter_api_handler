import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/models/api_response.dart';
import '../models/api_error_model.dart';
import '../models/error_type.dart';
import '../constants/default_error_messages.dart';

/// Custom error messages that can be provided to override defaults
class CustomErrorMessages {
  final String? errorNoInternet;
  final String? errorNoInternetMessage;
  final String? errorSlowConnection;
  final String? errorSlowConnectionMessage;
  final String? errorCancelled;
  final String? errorCancelledMessage;
  final String? errorCannotConnect;
  final String? errorCannotConnectMessage;
  final String? errorUnknown;
  final String? errorUnknownMessage;
  final String? errorBadRequest;
  final String? errorBadRequestMessage;
  final String? errorNeedLogin;
  final String? errorNeedLoginMessage;
  final String? errorNoPermission;
  final String? errorNoPermissionMessage;
  final String? errorNotFound;
  final String? errorNotFoundMessage;
  final String? errorConflict;
  final String? errorConflictMessage;
  final String? errorPayloadTooLarge;
  final String? errorPayloadTooLargeMessage;
  final String? errorInvalidInput;
  final String? errorInvalidInputMessage;
  final String? errorTooManyAttempts;
  final String? errorTooManyAttemptsMessage;
  final String? errorServerProblem;
  final String? errorServerProblemMessage;
  final String? errorDataFormat;
  final String? errorDataFormatMessage;
  final String? errorParsingData;
  final String? errorParsingDataMessage;
  final String? errorPaymentRequired;
  final String? errorPaymentRequiredMessage;
  final String? errorMethodNotAllowed;
  final String? errorMethodNotAllowedMessage;
  final String? errorNotAcceptable;
  final String? errorNotAcceptableMessage;
  final String? errorRequestTimeout;
  final String? errorRequestTimeoutMessage;
  final String? errorGone;
  final String? errorGoneMessage;
  final String? errorNotImplemented;
  final String? errorNotImplementedMessage;
  final String? errorBadGateway;
  final String? errorBadGatewayMessage;
  final String? errorServiceUnavailable;
  final String? errorServiceUnavailableMessage;
  final String? errorGatewayTimeout;
  final String? errorGatewayTimeoutMessage;
  final String? errorInvalidArgument;
  final String? errorInvalidArgumentMessage;
  final String? errorInvalidState;
  final String? errorInvalidStateMessage;
  final String? errorRangeError;
  final String? errorRangeErrorMessage;
  final String? errorUnsupportedOperation;
  final String? errorUnsupportedOperationMessage;
  final String? errorDns;
  final String? errorDnsMessage;
  final String? errorAccessDenied;
  final String? errorAccessDeniedMessage;
  final String? errorStorage;
  final String? errorStorageMessage;

  const CustomErrorMessages({
    this.errorNoInternet,
    this.errorNoInternetMessage,
    this.errorSlowConnection,
    this.errorSlowConnectionMessage,
    this.errorCancelled,
    this.errorCancelledMessage,
    this.errorCannotConnect,
    this.errorCannotConnectMessage,
    this.errorUnknown,
    this.errorUnknownMessage,
    this.errorBadRequest,
    this.errorBadRequestMessage,
    this.errorNeedLogin,
    this.errorNeedLoginMessage,
    this.errorNoPermission,
    this.errorNoPermissionMessage,
    this.errorNotFound,
    this.errorNotFoundMessage,
    this.errorConflict,
    this.errorConflictMessage,
    this.errorPayloadTooLarge,
    this.errorPayloadTooLargeMessage,
    this.errorInvalidInput,
    this.errorInvalidInputMessage,
    this.errorTooManyAttempts,
    this.errorTooManyAttemptsMessage,
    this.errorServerProblem,
    this.errorServerProblemMessage,
    this.errorDataFormat,
    this.errorDataFormatMessage,
    this.errorParsingData,
    this.errorParsingDataMessage,
    this.errorPaymentRequired,
    this.errorPaymentRequiredMessage,
    this.errorMethodNotAllowed,
    this.errorMethodNotAllowedMessage,
    this.errorNotAcceptable,
    this.errorNotAcceptableMessage,
    this.errorRequestTimeout,
    this.errorRequestTimeoutMessage,
    this.errorGone,
    this.errorGoneMessage,
    this.errorNotImplemented,
    this.errorNotImplementedMessage,
    this.errorBadGateway,
    this.errorBadGatewayMessage,
    this.errorServiceUnavailable,
    this.errorServiceUnavailableMessage,
    this.errorGatewayTimeout,
    this.errorGatewayTimeoutMessage,
    this.errorInvalidArgument,
    this.errorInvalidArgumentMessage,
    this.errorInvalidState,
    this.errorInvalidStateMessage,
    this.errorRangeError,
    this.errorRangeErrorMessage,
    this.errorUnsupportedOperation,
    this.errorUnsupportedOperationMessage,
    this.errorDns,
    this.errorDnsMessage,
    this.errorAccessDenied,
    this.errorAccessDeniedMessage,
    this.errorStorage,
    this.errorStorageMessage,
  });
}

class ErrorHandler {
  static CustomErrorMessages? _customMessages;

  /// Set custom error messages (call this in your app initialization)
  static void setCustomMessages(CustomErrorMessages messages) {
    _customMessages = messages;
  }

  /// Main entry point for all errors
  static UiError handle(dynamic exception, {ApiResponse? apiResponse}) {
    // Handle DioException (network errors)
    if (exception is DioException) {
      return _handleDioException(exception);
    }

    // Handle business logic errors from ApiResponse
    if (apiResponse != null && apiResponse.success == false) {
      return _handleBusinessLogicError(apiResponse);
    }

    // Handle data parsing errors
    if (exception is TypeError) {
      return _handleTypeError(exception);
    }

    if (exception is FormatException) {
      return _handleFormatException(exception);
    }

    // Handle Dart core errors
    if (exception is ArgumentError) {
      return _handleArgumentError(exception);
    }

    if (exception is StateError) {
      return _handleStateError(exception);
    }

    if (exception is RangeError) {
      return _handleRangeError(exception);
    }

    if (exception is UnsupportedError) {
      return _handleUnsupportedError(exception);
    }

    if (exception is UnimplementedError) {
      return _handleUnimplementedError(exception);
    }

    // Handle JSON serialization and casting errors
    final exceptionString = exception.toString();
    if (_isDataParsingError(exceptionString)) {
      return _handleDataParsingError(exception);
    }

    // Handle common error patterns before falling back to general
    return _handleGenericError(exception);
  }

  /// Handle DioException
  static UiError _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
        return UiError(
          title: _customMessages?.errorNoInternet ?? DefaultErrorMessages.errorNoInternet,
          message: _customMessages?.errorNoInternetMessage ?? DefaultErrorMessages.errorNoInternetMessage,
          icon: FontAwesomeIcons.wifi,
          type: ErrorType.network,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return UiError(
          title: _customMessages?.errorSlowConnection ?? DefaultErrorMessages.errorSlowConnection,
          message: _customMessages?.errorSlowConnectionMessage ?? DefaultErrorMessages.errorSlowConnectionMessage,
          icon: FontAwesomeIcons.clock,
          type: ErrorType.network,
        );

      case DioExceptionType.cancel:
        return UiError(
          title: _customMessages?.errorCancelled ?? DefaultErrorMessages.errorCancelled,
          message: _customMessages?.errorCancelledMessage ?? DefaultErrorMessages.errorCancelledMessage,
          icon: FontAwesomeIcons.ban,
          type: ErrorType.cancelled,
        );

      case DioExceptionType.badCertificate:
        return UiError(
          title: _customMessages?.errorCannotConnect ?? DefaultErrorMessages.errorCannotConnect,
          message: _customMessages?.errorCannotConnectMessage ?? DefaultErrorMessages.errorCannotConnectMessage,
          icon: FontAwesomeIcons.shieldHalved,
          type: ErrorType.network,
        );

      case DioExceptionType.unknown:
        return UiError(
          title: _customMessages?.errorUnknown ?? DefaultErrorMessages.errorUnknown,
          message: exception.message ?? (_customMessages?.errorUnknownMessage ?? DefaultErrorMessages.errorUnknownMessage),
          icon: FontAwesomeIcons.circleExclamation,
          type: ErrorType.unknown,
        );
    }
  }

  /// Handle bad HTTP response
  static UiError _handleBadResponse(DioException exception) {
    final statusCode = exception.response?.statusCode;
    final serverMessage = _extractErrorMessage(exception);
    final validationMessage = _extractValidationMessage(exception);

    return _handleStatusCode(statusCode, serverMessage, validationMessage);
  }

  /// Handle business logic errors
  static UiError _handleBusinessLogicError(ApiResponse apiResponse) {
    return _handleStatusCode(apiResponse.statusCode, apiResponse.message, null);
  }

  /// Centralized status code handling - comprehensive HTTP status coverage
  static UiError _handleStatusCode(
    int? statusCode,
    String? serverMessage,
    String? validationMessage,
  ) {
    switch (statusCode) {
      // Client Errors (4xx)
      case 400:
        return UiError(
          title: _customMessages?.errorBadRequest ?? DefaultErrorMessages.errorBadRequest,
          message: validationMessage ?? serverMessage ?? (_customMessages?.errorBadRequestMessage ?? DefaultErrorMessages.errorBadRequestMessage),
          icon: FontAwesomeIcons.circleExclamation,
          type: ErrorType.validation,
        );

      case 401:
        return UiError(
          title: _customMessages?.errorNeedLogin ?? DefaultErrorMessages.errorNeedLogin,
          message: serverMessage ?? (_customMessages?.errorNeedLoginMessage ?? DefaultErrorMessages.errorNeedLoginMessage),
          icon: FontAwesomeIcons.lock,
          type: ErrorType.authentication,
        );

      case 402:
        return UiError(
          title: _customMessages?.errorPaymentRequired ?? DefaultErrorMessages.errorPaymentRequired,
          message: serverMessage ?? (_customMessages?.errorPaymentRequiredMessage ?? DefaultErrorMessages.errorPaymentRequiredMessage),
          icon: FontAwesomeIcons.creditCard,
          type: ErrorType.authentication,
        );

      case 403:
        return UiError(
          title: _customMessages?.errorNoPermission ?? DefaultErrorMessages.errorNoPermission,
          message: serverMessage ?? (_customMessages?.errorNoPermissionMessage ?? DefaultErrorMessages.errorNoPermissionMessage),
          icon: FontAwesomeIcons.lock,
          type: ErrorType.authentication,
        );

      case 404:
        return UiError(
          title: _customMessages?.errorNotFound ?? DefaultErrorMessages.errorNotFound,
          message: serverMessage ?? (_customMessages?.errorNotFoundMessage ?? DefaultErrorMessages.errorNotFoundMessage),
          icon: FontAwesomeIcons.magnifyingGlass,
          type: ErrorType.notFound,
        );

      case 405:
        return UiError(
          title: _customMessages?.errorMethodNotAllowed ?? DefaultErrorMessages.errorMethodNotAllowed,
          message: serverMessage ?? (_customMessages?.errorMethodNotAllowedMessage ?? DefaultErrorMessages.errorMethodNotAllowedMessage),
          icon: FontAwesomeIcons.ban,
          type: ErrorType.validation,
        );

      case 406:
        return UiError(
          title: _customMessages?.errorNotAcceptable ?? DefaultErrorMessages.errorNotAcceptable,
          message: serverMessage ?? (_customMessages?.errorNotAcceptableMessage ?? DefaultErrorMessages.errorNotAcceptableMessage),
          icon: FontAwesomeIcons.fileCircleXmark,
          type: ErrorType.validation,
        );

      case 408:
        return UiError(
          title: _customMessages?.errorRequestTimeout ?? DefaultErrorMessages.errorRequestTimeout,
          message: serverMessage ?? (_customMessages?.errorRequestTimeoutMessage ?? DefaultErrorMessages.errorRequestTimeoutMessage),
          icon: FontAwesomeIcons.clock,
          type: ErrorType.network,
        );

      case 409:
        return UiError(
          title: _customMessages?.errorConflict ?? DefaultErrorMessages.errorConflict,
          message: serverMessage ?? (_customMessages?.errorConflictMessage ?? DefaultErrorMessages.errorConflictMessage),
          icon: FontAwesomeIcons.triangleExclamation,
          type: ErrorType.validation,
        );

      case 410:
        return UiError(
          title: _customMessages?.errorGone ?? DefaultErrorMessages.errorGone,
          message: serverMessage ?? (_customMessages?.errorGoneMessage ?? DefaultErrorMessages.errorGoneMessage),
          icon: FontAwesomeIcons.trash,
          type: ErrorType.notFound,
        );

      case 411:
        return UiError(
          title: "Length Required",
          message: serverMessage ?? "The request is missing the Content-Length header.",
          icon: FontAwesomeIcons.ruler,
          type: ErrorType.validation,
        );

      case 412:
        return UiError(
          title: "Precondition Failed",
          message: serverMessage ?? "One or more request preconditions failed.",
          icon: FontAwesomeIcons.xmark,
          type: ErrorType.validation,
        );

      case 413:
        return UiError(
          title: _customMessages?.errorPayloadTooLarge ?? DefaultErrorMessages.errorPayloadTooLarge,
          message: serverMessage ?? (_customMessages?.errorPayloadTooLargeMessage ?? DefaultErrorMessages.errorPayloadTooLargeMessage),
          icon: FontAwesomeIcons.file,
          type: ErrorType.validation,
        );

      case 414:
        return UiError(
          title: "URI Too Long",
          message: serverMessage ?? "The request URL is too long.",
          icon: FontAwesomeIcons.link,
          type: ErrorType.validation,
        );

      case 415:
        return UiError(
          title: "Unsupported Media Type",
          message: serverMessage ?? "The media type is not supported.",
          icon: FontAwesomeIcons.fileCircleXmark,
          type: ErrorType.validation,
        );

      case 416:
        return UiError(
          title: "Range Not Satisfiable",
          message: serverMessage ?? "The requested range cannot be satisfied.",
          icon: FontAwesomeIcons.arrowsLeftRight,
          type: ErrorType.validation,
        );

      case 417:
        return UiError(
          title: "Expectation Failed",
          message: serverMessage ?? "The server cannot meet the Expect request header.",
          icon: FontAwesomeIcons.questionCircle,
          type: ErrorType.validation,
        );

      case 418:
        return UiError(
          title: "I'm a teapot",
          message: serverMessage ?? "The server refuses to brew coffee because it's a teapot.",
          icon: FontAwesomeIcons.mugHot,
          type: ErrorType.server,
        );

      case 421:
        return UiError(
          title: "Misdirected Request",
          message: serverMessage ?? "The request was directed to a server that cannot produce a response.",
          icon: FontAwesomeIcons.route,
          type: ErrorType.validation,
        );

      case 422:
        return UiError(
          title: _customMessages?.errorInvalidInput ?? DefaultErrorMessages.errorInvalidInput,
          message: validationMessage ??
              serverMessage ??
              (_customMessages?.errorInvalidInputMessage ?? DefaultErrorMessages.errorInvalidInputMessage),
          icon: FontAwesomeIcons.circleExclamation,
          type: ErrorType.validation,
        );

      case 423:
        return UiError(
          title: "Locked",
          message: serverMessage ?? "The resource is locked.",
          icon: FontAwesomeIcons.lock,
          type: ErrorType.authentication,
        );

      case 424:
        return UiError(
          title: "Failed Dependency",
          message: serverMessage ?? "The request failed due to failure of a previous request.",
          icon: FontAwesomeIcons.chain,
          type: ErrorType.validation,
        );

      case 426:
        return UiError(
          title: "Upgrade Required",
          message: serverMessage ?? "Please upgrade your client to continue.",
          icon: FontAwesomeIcons.arrowUp,
          type: ErrorType.validation,
        );

      case 428:
        return UiError(
          title: "Precondition Required",
          message: serverMessage ?? "The request requires preconditions to be specified.",
          icon: FontAwesomeIcons.checkSquare,
          type: ErrorType.validation,
        );

      case 429:
        return UiError(
          title: _customMessages?.errorTooManyAttempts ?? DefaultErrorMessages.errorTooManyAttempts,
          message: serverMessage ?? (_customMessages?.errorTooManyAttemptsMessage ?? DefaultErrorMessages.errorTooManyAttemptsMessage),
          icon: FontAwesomeIcons.clock,
          type: ErrorType.server,
        );

      case 431:
        return UiError(
          title: "Request Header Fields Too Large",
          message: serverMessage ?? "The request headers are too large.",
          icon: FontAwesomeIcons.textHeight,
          type: ErrorType.validation,
        );

      case 451:
        return UiError(
          title: "Unavailable For Legal Reasons",
          message: serverMessage ?? "This content is unavailable for legal reasons.",
          icon: FontAwesomeIcons.balanceScale,
          type: ErrorType.authentication,
        );

      // Server Errors (5xx)
      case 500:
        return UiError(
          title: _customMessages?.errorServerProblem ?? DefaultErrorMessages.errorServerProblem,
          message: serverMessage ?? (_customMessages?.errorServerProblemMessage ?? DefaultErrorMessages.errorServerProblemMessage),
          icon: FontAwesomeIcons.server,
          type: ErrorType.server,
        );

      case 501:
        return UiError(
          title: _customMessages?.errorNotImplemented ?? DefaultErrorMessages.errorNotImplemented,
          message: serverMessage ?? (_customMessages?.errorNotImplementedMessage ?? DefaultErrorMessages.errorNotImplementedMessage),
          icon: FontAwesomeIcons.wrench,
          type: ErrorType.server,
        );

      case 502:
        return UiError(
          title: _customMessages?.errorBadGateway ?? DefaultErrorMessages.errorBadGateway,
          message: serverMessage ?? (_customMessages?.errorBadGatewayMessage ?? DefaultErrorMessages.errorBadGatewayMessage),
          icon: FontAwesomeIcons.server,
          type: ErrorType.server,
        );

      case 503:
        return UiError(
          title: _customMessages?.errorServiceUnavailable ?? DefaultErrorMessages.errorServiceUnavailable,
          message: serverMessage ?? (_customMessages?.errorServiceUnavailableMessage ?? DefaultErrorMessages.errorServiceUnavailableMessage),
          icon: FontAwesomeIcons.tools,
          type: ErrorType.server,
        );

      case 504:
        return UiError(
          title: _customMessages?.errorGatewayTimeout ?? DefaultErrorMessages.errorGatewayTimeout,
          message: serverMessage ?? (_customMessages?.errorGatewayTimeoutMessage ?? DefaultErrorMessages.errorGatewayTimeoutMessage),
          icon: FontAwesomeIcons.clock,
          type: ErrorType.server,
        );

      case 505:
        return UiError(
          title: "HTTP Version Not Supported",
          message: serverMessage ?? "The HTTP version used in the request is not supported.",
          icon: FontAwesomeIcons.code,
          type: ErrorType.server,
        );

      case 506:
        return UiError(
          title: "Variant Also Negotiates",
          message: serverMessage ?? "There is an internal configuration error.",
          icon: FontAwesomeIcons.cogs,
          type: ErrorType.server,
        );

      case 507:
        return UiError(
          title: "Insufficient Storage",
          message: serverMessage ?? "The server is unable to store the representation.",
          icon: FontAwesomeIcons.database,
          type: ErrorType.server,
        );

      case 508:
        return UiError(
          title: "Loop Detected",
          message: serverMessage ?? "The server detected an infinite loop.",
          icon: FontAwesomeIcons.repeat,
          type: ErrorType.server,
        );

      case 510:
        return UiError(
          title: "Not Extended",
          message: serverMessage ?? "Further extensions to the request are required.",
          icon: FontAwesomeIcons.plus,
          type: ErrorType.server,
        );

      case 511:
        return UiError(
          title: "Network Authentication Required",
          message: serverMessage ?? "Network authentication is required to access this resource.",
          icon: FontAwesomeIcons.wifi,
          type: ErrorType.authentication,
        );

      default:
        return UiError(
          title: _customMessages?.errorUnknown ?? DefaultErrorMessages.errorUnknown,
          message: serverMessage ?? (_customMessages?.errorUnknownMessage ?? DefaultErrorMessages.errorUnknownMessage),
          icon: FontAwesomeIcons.circleExclamation,
          type: ErrorType.unknown,
        );
    }
  }

  /// Check if exception is a data parsing error
  static bool _isDataParsingError(String exceptionString) {
    final patterns = [
      'type ',
      ' is not a subtype of ',
      'Failed assertion',
      'Unexpected null',
      'NoSuchMethodError',
      'Invalid JSON',
      'FormatException',
      'RangeError',
      'Null check operator used on a null value',
      'Bad state',
      'StateError',
      'ArgumentError',
      'UnsupportedError',
      'UnimplementedError',
      'ConcurrentModificationError',
      'CyclicInitializationError',
      'json.decode',
      'jsonDecode',
      '_CastError',
      'toString() was called on null',
      'Invalid argument',
      'Out of Memory',
      'StackOverflowError',
      '_TypeError',
      '_InternalError',
    ];

    final lowerString = exceptionString.toLowerCase();
    return patterns.any(
      (pattern) => lowerString.contains(pattern.toLowerCase()),
    );
  }

  /// Extract error message from response data
  /// Different APIs use different keys for error messages
  static String? _extractErrorMessage(DioException exception) {
    final data = exception.response?.data;

    if (data == null) return null;

    // Handle string responses
    if (data is String) {
      return data.isNotEmpty ? data : null;
    }

    // Handle JSON responses
    if (data is Map<String, dynamic>) {
      // Try common error message keys (order matters - most to least common)
      return data['message'] as String? ??
          data['error'] as String? ??
          data['msg'] as String? ??
          data['detail'] as String? ??
          data['errorMessage'] as String? ??
          data['error_description'] as String?;
    }

    return null;
  }

  /// Extract validation message from response
  static String? _extractValidationMessage(DioException exception) {
    final data = exception.response?.data;

    if (data is! Map<String, dynamic>) return null;

    // Check for validation errors object
    final errorsKeys = [
      'errors',
      'validation_errors',
      'validationErrors',
      'fields',
    ];

    for (final key in errorsKeys) {
      final errorsValue = data[key];

      // Handle Map of errors
      if (errorsValue is Map && errorsValue.isNotEmpty) {
        final firstError = errorsValue.values.first;

        // Handle array of error messages
        if (firstError is List && firstError.isNotEmpty) {
          return firstError.first.toString();
        }

        // Handle single error message
        if (firstError is String && firstError.isNotEmpty) {
          return firstError;
        }
      }

      // Handle List of errors
      if (errorsValue is List && errorsValue.isNotEmpty) {
        final firstError = errorsValue.first;
        if (firstError is String && firstError.isNotEmpty) {
          return firstError;
        }
        if (firstError is Map && firstError.isNotEmpty) {
          final message = firstError.values.first;
          if (message is String && message.isNotEmpty) {
            return message;
          }
        }
      }
    }

    // Fallback to regular message
    return _extractErrorMessage(exception);
  }

  /// Handle TypeError - usually from casting issues
  static UiError _handleTypeError(TypeError exception) {
    return UiError(
      title: _customMessages?.errorDataFormat ?? DefaultErrorMessages.errorDataFormat,
      message: _customMessages?.errorDataFormatMessage ?? DefaultErrorMessages.errorDataFormatMessage,
      icon: FontAwesomeIcons.triangleExclamation,
      type: ErrorType.validation,
    );
  }

  /// Handle FormatException - usually from JSON parsing
  static UiError _handleFormatException(FormatException exception) {
    return UiError(
      title: _customMessages?.errorParsingData ?? DefaultErrorMessages.errorParsingData,
      message: _customMessages?.errorParsingDataMessage ?? DefaultErrorMessages.errorParsingDataMessage,
      icon: FontAwesomeIcons.fileCircleExclamation,
      type: ErrorType.validation,
    );
  }

  /// Handle general data parsing errors
  static UiError _handleDataParsingError(dynamic exception) {
    return UiError(
      title: _customMessages?.errorParsingData ?? DefaultErrorMessages.errorParsingData,
      message: _customMessages?.errorParsingDataMessage ?? DefaultErrorMessages.errorParsingDataMessage,
      icon: FontAwesomeIcons.fileCircleExclamation,
      type: ErrorType.validation,
    );
  }

  /// Handle generic errors with pattern detection
  static UiError _handleGenericError(dynamic exception) {
    // Handle common error patterns that might slip through
    final errorString = exception.toString().toLowerCase();

    // Network related errors
    if (errorString.contains('socket') || 
        errorString.contains('network') ||
        errorString.contains('connection refused') ||
        errorString.contains('host lookup failed') ||
        errorString.contains('no route to host') ||
        errorString.contains('network is unreachable')) {
      return UiError(
        title: _customMessages?.errorNoInternet ?? DefaultErrorMessages.errorNoInternet,
        message: _customMessages?.errorNoInternetMessage ?? DefaultErrorMessages.errorNoInternetMessage,
        icon: FontAwesomeIcons.wifi,
        type: ErrorType.network,
      );
    } 
    
    // Timeout related errors
    else if (errorString.contains('timeout') ||
             errorString.contains('timed out') ||
             errorString.contains('deadline exceeded')) {
      return UiError(
        title: _customMessages?.errorSlowConnection ?? DefaultErrorMessages.errorSlowConnection,
        message: _customMessages?.errorSlowConnectionMessage ?? DefaultErrorMessages.errorSlowConnectionMessage,
        icon: FontAwesomeIcons.clock,
        type: ErrorType.network,
      );
    } 
    
    // SSL/TLS related errors
    else if (errorString.contains('certificate') ||
             errorString.contains('ssl') ||
             errorString.contains('tls') ||
             errorString.contains('handshake') ||
             errorString.contains('peer reset') ||
             errorString.contains('connection reset')) {
      return UiError(
        title: _customMessages?.errorCannotConnect ?? DefaultErrorMessages.errorCannotConnect,
        message: _customMessages?.errorCannotConnectMessage ?? DefaultErrorMessages.errorCannotConnectMessage,
        icon: FontAwesomeIcons.shieldHalved,
        type: ErrorType.network,
      );
    }
    
    // DNS related errors
    else if (errorString.contains('dns') ||
             errorString.contains('name resolution') ||
             errorString.contains('nodename nor servname provided')) {
      return UiError(
        title: _customMessages?.errorDns ?? DefaultErrorMessages.errorDns,
        message: _customMessages?.errorDnsMessage ?? DefaultErrorMessages.errorDnsMessage,
        icon: FontAwesomeIcons.globe,
        type: ErrorType.network,
      );
    }
    
    // Permission/Access errors
    else if (errorString.contains('permission denied') ||
             errorString.contains('access denied') ||
             errorString.contains('unauthorized')) {
      return UiError(
        title: _customMessages?.errorAccessDenied ?? DefaultErrorMessages.errorAccessDenied,
        message: _customMessages?.errorAccessDeniedMessage ?? DefaultErrorMessages.errorAccessDeniedMessage,
        icon: FontAwesomeIcons.lock,
        type: ErrorType.authentication,
      );
    }
    
    // File/Storage errors
    else if (errorString.contains('file not found') ||
             errorString.contains('no space left') ||
             errorString.contains('disk full') ||
             errorString.contains('storage')) {
      return UiError(
        title: _customMessages?.errorStorage ?? DefaultErrorMessages.errorStorage,
        message: _customMessages?.errorStorageMessage ?? DefaultErrorMessages.errorStorageMessage,
        icon: FontAwesomeIcons.hardDrive,
        type: ErrorType.validation,
      );
    }

    // Fallback to general error
    return UiError.general(exception);
  }

  /// Handle ArgumentError - invalid arguments
  static UiError _handleArgumentError(ArgumentError exception) {
    return UiError(
      title: _customMessages?.errorInvalidArgument ?? DefaultErrorMessages.errorInvalidArgument,
      message: exception.message ?? (_customMessages?.errorInvalidArgumentMessage ?? DefaultErrorMessages.errorInvalidArgumentMessage),
      icon: FontAwesomeIcons.triangleExclamation,
      type: ErrorType.validation,
    );
  }

  /// Handle StateError - invalid state
  static UiError _handleStateError(StateError exception) {
    return UiError(
      title: _customMessages?.errorInvalidState ?? DefaultErrorMessages.errorInvalidState,
      message: exception.message ?? (_customMessages?.errorInvalidStateMessage ?? DefaultErrorMessages.errorInvalidStateMessage),
      icon: FontAwesomeIcons.exclamationCircle,
      type: ErrorType.validation,
    );
  }

  /// Handle RangeError - index out of range
  static UiError _handleRangeError(RangeError exception) {
    return UiError(
      title: _customMessages?.errorRangeError ?? DefaultErrorMessages.errorRangeError,
      message: _customMessages?.errorRangeErrorMessage ?? DefaultErrorMessages.errorRangeErrorMessage,
      icon: FontAwesomeIcons.listOl,
      type: ErrorType.validation,
    );
  }

  /// Handle UnsupportedError - unsupported operation
  static UiError _handleUnsupportedError(UnsupportedError exception) {
    return UiError(
      title: _customMessages?.errorUnsupportedOperation ?? DefaultErrorMessages.errorUnsupportedOperation,
      message: exception.message ?? (_customMessages?.errorUnsupportedOperationMessage ?? DefaultErrorMessages.errorUnsupportedOperationMessage),
      icon: FontAwesomeIcons.ban,
      type: ErrorType.validation,
    );
  }

  /// Handle UnimplementedError - unimplemented feature
  static UiError _handleUnimplementedError(UnimplementedError exception) {
    return UiError(
      title: _customMessages?.errorNotImplemented ?? DefaultErrorMessages.errorNotImplemented,
      message: exception.message ?? (_customMessages?.errorNotImplementedMessage ?? DefaultErrorMessages.errorNotImplementedMessage),
      icon: FontAwesomeIcons.wrench,
      type: ErrorType.validation,
    );
  }
}