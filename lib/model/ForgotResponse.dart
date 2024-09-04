

class ForgotResponse {
  final bool status;
  final String errors;
  final int statusCode;

  ForgotResponse({
    required this.status,
    required this.errors,
    required this.statusCode,
  });

  factory ForgotResponse.fromJson(Map<String, dynamic> json) {
    return ForgotResponse(
      status: json['status'] as bool,
      errors: json['errors'] as String,
      statusCode: json['statusCode'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'errors': errors,
      'statusCode': statusCode,
    };
  }
}
