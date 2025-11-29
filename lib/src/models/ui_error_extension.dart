import 'package:flutter/material.dart';
import 'api_error_model.dart';
import 'error_action.dart';

extension UiErrorExtension on UiError {
  /// Get primary action for this error
  ErrorAction? getPrimaryAction({
    required BuildContext context,
    VoidCallback? onRetry,
  }) {
    return ErrorActionHelper.getDefaultAction(
      context: context,
      errorType: type,
      onRetry: onRetry,
    );
  }

  /// Get secondary action for this error
  ErrorAction? getSecondaryAction(BuildContext context) {
    return ErrorActionHelper.getSecondaryAction(
      context: context,
      errorType: type,
    );
  }

  /// Show error as dialog
  void showAsDialog(
    BuildContext context, {
    VoidCallback? onRetry,
    String cancelText = "Cancel",
  }) {
    final primaryAction = getPrimaryAction(context: context, onRetry: onRetry);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(icon, size: 48, color: foregroundColor),
        title: Text(title),
        content: Text(message),
        actions: [
          if (primaryAction != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                primaryAction.onPressed();
              },
              child: Text(primaryAction.label),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelText),
          ),
        ],
      ),
    );
  }

  /// Show error as snackbar
  void showAsSnackBar(
    BuildContext context, {
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 4),
  }) {
    final primaryAction = getPrimaryAction(context: context, onRetry: onRetry);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: primaryAction != null
            ? SnackBarAction(
                label: primaryAction.label,
                onPressed: primaryAction.onPressed,
              )
            : null,
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Show error as full-screen widget
  Widget asWidget({
    VoidCallback? onRetry,
    VoidCallback? onSecondaryAction,
    EdgeInsets padding = const EdgeInsets.all(24),
  }) {
    return ErrorStateWidget(
      error: this,
      onRetry: onRetry,
      onSecondaryAction: onSecondaryAction,
      padding: padding,
    );
  }
}

/// Simple error widget implementation
/// You can replace this with your own error widget
class ErrorStateWidget extends StatelessWidget {
  final UiError error;
  final VoidCallback? onRetry;
  final VoidCallback? onSecondaryAction;
  final EdgeInsets padding;

  const ErrorStateWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.onSecondaryAction,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            error.icon,
            size: 64,
            color: error.foregroundColor,
          ),
          const SizedBox(height: 16),
          Text(
            error.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            error.message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          if (onSecondaryAction != null) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: onSecondaryAction,
              child: const Text('Go Back'),
            ),
          ],
        ],
      ),
    );
  }
}