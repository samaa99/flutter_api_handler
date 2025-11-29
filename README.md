# Flutter API Helpers

A comprehensive Flutter package for API error handling, HTTP client management, and network request utilities with customizable error messages and types.

## Features

- 🔧 **Configurable Dio HTTP Client** with timeout and logging options
- 🚨 **Comprehensive Error Handling** for all HTTP status codes and network errors
- 🎨 **Customizable Error Messages** that can be localized or branded
- 🔄 **Result Pattern** for clean success/failure handling
- 📱 **UI Extensions** for showing errors as dialogs, snackbars, or full-screen widgets
- 🎯 **Type-Safe Error Actions** with built-in retry and navigation actions

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_api_helpers:
    git:
      url: https://github.com/samaa99/flutter_api_handler.git
      ref: main
```

## Quick Start

### 1. Basic Setup

```dart
import 'package:flutter_api_helpers/flutter_api_helpers.dart';

// Create a Dio instance
final dio = DioFactory.createDio();

// Optional: Configure with custom settings
final customDio = DioFactory.createDio(
  DioConfig(
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    enableLogging: true,
  ),
);
```

### 2. Handle API Responses

```dart
try {
  final response = await dio.get('/api/users');
  // Handle success
  final result = Result<List<User>, UiError>.success(users);
} catch (e) {
  // Handle errors
  final error = ErrorHandler.handle(e);
  final result = Result<List<User>, UiError>.failure(error);
  
  // Show error to user
  error.showAsSnackBar(context);
  // or
  error.showAsDialog(context, onRetry: () => fetchUsers());
  // or use as widget
  return error.asWidget(onRetry: () => fetchUsers());
}
```

### 3. Custom Error Messages

```dart
void main() {
  // Set custom error messages at app startup
  ErrorHandler.setCustomMessages(
    CustomErrorMessages(
      errorNoInternet: "Check Your Connection",
      errorNoInternetMessage: "Please verify your internet connection and try again.",
      errorServerProblem: "Server Maintenance",
      errorServerProblemMessage: "Our servers are currently under maintenance.",
    ),
  );
  
  runApp(MyApp());
}
```

### 4. Using Result Pattern

```dart
Future<Result<List<User>, UiError>> fetchUsers() async {
  try {
    final response = await dio.get('/api/users');
    final users = (response.data as List)
        .map((json) => User.fromJson(json))
        .toList();
    return Result.success(users);
  } catch (e) {
    final error = ErrorHandler.handle(e);
    return Result.failure(error);
  }
}

// Usage
final result = await fetchUsers();
result.when(
  success: (users) => showUsers(users),
  failure: (error) => error.showAsSnackBar(context),
);
```

## Error Types

The package handles various error types:

- **Network Errors**: Connection issues, timeouts, SSL problems
- **HTTP Status Codes**: 400, 401, 403, 404, 409, 422, 429, 500, etc.
- **Data Parsing Errors**: JSON parsing, type casting issues
- **Business Logic Errors**: Custom API response errors

## UI Extensions

### Show as Dialog

```dart
error.showAsDialog(
  context,
  onRetry: () => retryAction(),
  cancelText: "Cancel", // Optional
);
```

### Show as SnackBar

```dart
error.showAsSnackBar(
  context,
  onRetry: () => retryAction(),
  duration: Duration(seconds: 4), // Optional
);
```

### Use as Widget

```dart
Widget build(BuildContext context) {
  if (state.hasError) {
    return state.error.asWidget(
      onRetry: () => bloc.add(RetryEvent()),
      padding: EdgeInsets.all(16),
    );
  }
  return SuccessWidget();
}
```

## Customization

### Custom Dio Configuration

```dart
final dio = DioFactory.createDio(
  DioConfig(
    connectTimeout: Duration(seconds: 45),
    receiveTimeout: Duration(seconds: 45),
    enableLogging: false, // Disable in production
    requestHeader: true,
    requestBody: false,
    responseBody: true,
  ),
);
```

### Custom Error Actions

```dart
extension CustomErrorActions on UiError {
  void showWithCustomActions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/support'),
            child: Text('Contact Support'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
```

## API Response Model

The package includes a basic `ApiResponse` model that you can replace with your own:

```dart
class ApiResponse {
  final bool success;
  final String? message;
  final int? statusCode;
  final dynamic data;
  // ... your implementation
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.