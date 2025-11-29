import 'package:flutter/material.dart';

import 'error_type.dart';

class ErrorAction {
  final String label;
  final VoidCallback onPressed;

  const ErrorAction({required this.label, required this.onPressed});
}

class ErrorActionHelper {
  /// Get default action based on error type
  static ErrorAction? getDefaultAction({
    required BuildContext context,
    required ErrorType errorType,
    VoidCallback? onRetry,
  }) {
    switch (errorType) {
      case ErrorType.network:
      case ErrorType.server:
      case ErrorType.unknown:
        if (onRetry != null) {
          return ErrorAction(label: 'Retry', onPressed: onRetry);
        }
        return null;

      // TODO: You should add your own error handling here
      case ErrorType.authentication:
        return ErrorAction(
          label: 'Login',
          onPressed: () => Navigator.pushNamed(context, '/login'),
        );

      case ErrorType.notFound:
        return ErrorAction(
          label: 'Go Back',
          onPressed: () => Navigator.pop(context),
        );

      case ErrorType.validation:
        return ErrorAction(
          label: 'OK',
          onPressed: () => Navigator.pop(context),
        );

      case ErrorType.cancelled:
        return null; // No action needed for cancelled operations
    }
  }

  /// Get secondary action (optional)
  static ErrorAction? getSecondaryAction({
    required BuildContext context,
    required ErrorType errorType,
  }) {
    switch (errorType) {
      // TODO: You should add your own error handling here
      case ErrorType.network:
        return ErrorAction(
          label: 'Settings',
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        );

      // TODO: You should add your own error handling here
      case ErrorType.authentication:
        return ErrorAction(
          label: 'Sign Up',
          onPressed: () => Navigator.pushNamed(context, '/signup'),
        );

      default:
        return null;
    }
  }
}