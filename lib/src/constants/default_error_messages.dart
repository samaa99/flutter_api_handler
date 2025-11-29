/// Default error messages for the API helpers package
/// These can be overridden by providing custom messages to the error handler
class DefaultErrorMessages {
  static const String errorNoInternet = "No Internet Connection";
  static const String errorNoInternetMessage = 
      "Please check your internet connection and try again.";
  
  static const String errorSlowConnection = "Slow Connection";
  static const String errorSlowConnectionMessage = 
      "The request is taking longer than expected. Please try again.";
  
  static const String errorCancelled = "Request Cancelled";
  static const String errorCancelledMessage = 
      "The request was cancelled before it could complete.";
  
  static const String errorCannotConnect = "Cannot Connect";
  static const String errorCannotConnectMessage = 
      "Unable to connect to the server. Please try again later.";
  
  static const String errorUnknown = "Unknown Error";
  static const String errorUnknownMessage = 
      "An unexpected error occurred. Please try again.";
  
  static const String errorBadRequest = "Invalid Request";
  static const String errorBadRequestMessage = 
      "The request contains invalid data. Please check and try again.";
  
  static const String errorNeedLogin = "Authentication Required";
  static const String errorNeedLoginMessage = 
      "You need to log in to access this feature.";
  
  static const String errorNoPermission = "Access Denied";
  static const String errorNoPermissionMessage = 
      "You don't have permission to access this resource.";
  
  static const String errorNotFound = "Not Found";
  static const String errorNotFoundMessage = 
      "The requested resource could not be found.";
  
  static const String errorConflict = "Conflict";
  static const String errorConflictMessage = 
      "There was a conflict with the current state of the resource.";
  
  static const String errorPayloadTooLarge = "File Too Large";
  static const String errorPayloadTooLargeMessage = 
      "The file you're trying to upload is too large.";
  
  static const String errorInvalidInput = "Invalid Input";
  static const String errorInvalidInputMessage = 
      "Please check your input and try again.";
  
  static const String errorTooManyAttempts = "Too Many Attempts";
  static const String errorTooManyAttemptsMessage = 
      "Too many attempts. Please wait before trying again.";
  
  static const String errorServerProblem = "Server Error";
  static const String errorServerProblemMessage = 
      "There's a problem with our servers. Please try again later.";
  
  static const String errorDataFormat = "Data Format Error";
  static const String errorDataFormatMessage = 
      "The received data is in an unexpected format.";
  
  static const String errorParsingData = "Data Parsing Error";
  static const String errorParsingDataMessage = 
      "Unable to process the received data.";
  
  // Additional HTTP status errors
  static const String errorPaymentRequired = "Payment Required";
  static const String errorPaymentRequiredMessage = 
      "Payment is required to access this resource.";
  
  static const String errorMethodNotAllowed = "Method Not Allowed";
  static const String errorMethodNotAllowedMessage = 
      "The request method is not supported for this resource.";
  
  static const String errorNotAcceptable = "Not Acceptable";
  static const String errorNotAcceptableMessage = 
      "The requested format is not supported.";
  
  static const String errorRequestTimeout = "Request Timeout";
  static const String errorRequestTimeoutMessage = 
      "The request took too long to process.";
  
  static const String errorGone = "Gone";
  static const String errorGoneMessage = 
      "The requested resource is no longer available.";
  
  static const String errorNotImplemented = "Not Implemented";
  static const String errorNotImplementedMessage = 
      "This functionality is not implemented yet.";
  
  static const String errorBadGateway = "Bad Gateway";
  static const String errorBadGatewayMessage = 
      "The server received an invalid response from an upstream server.";
  
  static const String errorServiceUnavailable = "Service Unavailable";
  static const String errorServiceUnavailableMessage = 
      "The service is temporarily unavailable. Please try again later.";
  
  static const String errorGatewayTimeout = "Gateway Timeout";
  static const String errorGatewayTimeoutMessage = 
      "The server took too long to respond.";
  
  // Dart core errors
  static const String errorInvalidArgument = "Invalid Argument";
  static const String errorInvalidArgumentMessage = 
      "An invalid argument was provided.";
  
  static const String errorInvalidState = "Invalid State";
  static const String errorInvalidStateMessage = 
      "The operation cannot be performed in the current state.";
  
  static const String errorRangeError = "Range Error";
  static const String errorRangeErrorMessage = 
      "The requested index or range is invalid.";
  
  static const String errorUnsupportedOperation = "Unsupported Operation";
  static const String errorUnsupportedOperationMessage = 
      "This operation is not supported.";
  
  static const String errorDns = "DNS Error";
  static const String errorDnsMessage = 
      "Unable to resolve the server address. Check your network connection.";
  
  static const String errorAccessDenied = "Access Denied";
  static const String errorAccessDeniedMessage = 
      "You don't have permission to access this resource.";
  
  static const String errorStorage = "Storage Error";
  static const String errorStorageMessage = 
      "There was an issue with file storage or access.";

  // Additional HTTP status errors (4xx client errors)
  static const String errorLengthRequired = "Length Required";
  static const String errorLengthRequiredMessage = 
      "The request is missing the Content-Length header.";
      
  static const String errorPreconditionFailed = "Precondition Failed";
  static const String errorPreconditionFailedMessage = 
      "One or more request preconditions failed.";
      
  static const String errorUriTooLong = "URI Too Long";
  static const String errorUriTooLongMessage = 
      "The request URL is too long.";
      
  static const String errorUnsupportedMediaType = "Unsupported Media Type";
  static const String errorUnsupportedMediaTypeMessage = 
      "The media type is not supported.";
      
  static const String errorRangeNotSatisfiable = "Range Not Satisfiable";
  static const String errorRangeNotSatisfiableMessage = 
      "The requested range cannot be satisfied.";
      
  static const String errorExpectationFailed = "Expectation Failed";
  static const String errorExpectationFailedMessage = 
      "The server cannot meet the Expect request header.";
      
  static const String errorTeapot = "I'm a teapot";
  static const String errorTeapotMessage = 
      "The server refuses to brew coffee because it's a teapot.";
      
  static const String errorMisdirectedRequest = "Misdirected Request";
  static const String errorMisdirectedRequestMessage = 
      "The request was directed to a server that cannot produce a response.";
      
  static const String errorLocked = "Locked";
  static const String errorLockedMessage = 
      "The resource is locked.";
      
  static const String errorFailedDependency = "Failed Dependency";
  static const String errorFailedDependencyMessage = 
      "The request failed due to failure of a previous request.";
      
  static const String errorUpgradeRequired = "Upgrade Required";
  static const String errorUpgradeRequiredMessage = 
      "Please upgrade your client to continue.";
      
  static const String errorPreconditionRequired = "Precondition Required";
  static const String errorPreconditionRequiredMessage = 
      "The request requires preconditions to be specified.";
      
  static const String errorRequestHeaderFieldsTooLarge = "Request Header Fields Too Large";
  static const String errorRequestHeaderFieldsTooLargeMessage = 
      "The request headers are too large.";
      
  static const String errorUnavailableForLegalReasons = "Unavailable For Legal Reasons";
  static const String errorUnavailableForLegalReasonsMessage = 
      "This content is unavailable for legal reasons.";

  // Additional HTTP status errors (5xx server errors)
  static const String errorHttpVersionNotSupported = "HTTP Version Not Supported";
  static const String errorHttpVersionNotSupportedMessage = 
      "The HTTP version used in the request is not supported.";
      
  static const String errorVariantAlsoNegotiates = "Variant Also Negotiates";
  static const String errorVariantAlsoNegotiatesMessage = 
      "There is an internal configuration error.";
      
  static const String errorInsufficientStorage = "Insufficient Storage";
  static const String errorInsufficientStorageMessage = 
      "The server is unable to store the representation.";
      
  static const String errorLoopDetected = "Loop Detected";
  static const String errorLoopDetectedMessage = 
      "The server detected an infinite loop.";
      
  static const String errorNotExtended = "Not Extended";
  static const String errorNotExtendedMessage = 
      "Further extensions to the request are required.";
      
  static const String errorNetworkAuthenticationRequired = "Network Authentication Required";
  static const String errorNetworkAuthenticationRequiredMessage = 
      "Network authentication is required to access this resource.";
}