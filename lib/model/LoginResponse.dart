


class LoginResponse {
  final bool status;
  final String? token;
  final User? user;
  final int? statusCode;

  LoginResponse({
    required this.status,
    this.token,
    this.user,
    this.statusCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] as bool,
      token: json['data']?['token'] as String?,
      user: json['data']?['user'] != null ? User.fromJson(json['data']['user']) : null,
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': {
        'token': token,
        'user': user?.toJson(),
      },
      'statusCode': statusCode,
    };
  }
}

class User {
  final int id;
  final String uuid;
  final String name;
  final String email;
  final int? departmentId;
  final String? mobileNumber;

  User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    this.departmentId,
    this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      departmentId: json['department_id'] as int?,
      mobileNumber: json['mobile_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'email': email,
      'department_id': departmentId,
      'mobile_number': mobileNumber,
    };
  }
}

/*class LoginResponse {
  bool? status;
  final String? token;
  final User user;
  final int? statusCode;

  LoginResponse( {required this.token, required this.user, required this.status, required this.statusCode,});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      status: json['status'] as bool,
      statusCode: json['statusCode'] as int,
      user: User.fromJson(json['user']),
    );
  }



}
class User {
  final int? id;
  final String? uuid;
  final String? name;
  final String? email;
  final int departmentId;
  final String? emailVerifiedAt;
  final String? mobileNumber;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final int? districtId;
  final int? designationId;

  User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.departmentId,
    this.emailVerifiedAt,
    required this.mobileNumber,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.districtId,
    this.designationId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      departmentId: json['department_id'] as int,
      emailVerifiedAt: json['email_verified_at'] as String,
      mobileNumber: json['mobile_number'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      deletedAt: json['deleted_at'] as String,
      districtId: json['district_id'] as int,
      designationId: json['designation_id'] as int,
    );
  }
}*/

