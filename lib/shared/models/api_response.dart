/// Basic API response model
/// You can replace this with your own API response model
class ApiResponse {
  final bool success;
  final String? message;
  final int? statusCode;
  final dynamic data;

  ApiResponse({
    required this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? false,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'statusCode': statusCode,
      'data': data,
    };
  }
}