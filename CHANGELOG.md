# Changelog

## [1.0.0] - 2025-11-29

### Added
- Initial release of Flutter API Helpers package
- Comprehensive error handling for HTTP status codes and network errors
- Configurable Dio HTTP client factory with timeout and logging options
- Result pattern for clean success/failure handling
- UI extensions for showing errors as dialogs, snackbars, or widgets
- Customizable error messages that can be localized or branded
- Type-safe error actions with built-in retry and navigation
- Example application demonstrating usage
- Complete documentation and README

### Features
- **DioFactory**: Configurable HTTP client creation
- **ErrorHandler**: Handles DioException, HTTP status codes, and parsing errors
- **Result<T, E>**: Success/failure result pattern
- **UiError**: Rich error model with title, message, icon, and type
- **UiErrorExtension**: Show errors as dialog, snackbar, or widget
- **CustomErrorMessages**: Override default messages for branding/localization
- **ErrorAction**: Type-safe error action handling