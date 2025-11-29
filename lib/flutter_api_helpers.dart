/// Flutter API Helpers - A comprehensive package for API error handling and HTTP client management
library flutter_api_helpers;

// Export all models
export 'src/models/api_error_model.dart';
export 'src/models/api_result.dart';
export 'src/models/error_action.dart';
export 'src/models/error_type.dart';
export 'src/models/ui_error_extension.dart';

// Export handlers
export 'src/handlers/error_handler.dart';

// Export factories
export 'src/factories/dio_factory.dart';

// Export constants
export 'src/constants/api_constants.dart';
export 'src/constants/default_error_messages.dart';

// Export shared models
export 'shared/models/api_response.dart';