import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/default_error_messages.dart';
import 'error_type.dart';

class UiError {
  final String title; // "Network Error"
  final String message; // "Check your connection"
  final IconData icon; // Icons.wifi_off
  final Color foregroundColor; // Colors.red
  final ErrorType type;

  const UiError({
    required this.title,
    required this.message,
    required this.icon,
    required this.type,
    this.foregroundColor = Colors.deepPurple,
  });

  factory UiError.general(dynamic e) {
    // You can implement your own logging here
    debugPrint('UiError.general: ${e.runtimeType} - ${e.toString()}');

    return UiError(
      title: DefaultErrorMessages.errorUnknown,
      message: DefaultErrorMessages.errorUnknownMessage,
      icon: FontAwesomeIcons.triangleExclamation,
      type: ErrorType.unknown,
    );
  }
}