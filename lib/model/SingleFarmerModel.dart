import 'dart:convert';

class Singlefarmermodel {
  bool status;
  int statusCode;
  String message;
  FarmerData data;

  Singlefarmermodel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory Singlefarmermodel.fromJson(Map<String, dynamic> json) {
    return Singlefarmermodel(
      status: json['status'] is bool ? json['status'] : false,
      statusCode: json['statusCode'] is int ? json['statusCode'] : 0,
      message: json['message'] is String ? json['message'] : '',
      data: json['data'] != null ? FarmerData.fromJson(json['data']) : FarmerData.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class FarmerData {
  Farmer farmer;

  FarmerData({required this.farmer});

  factory FarmerData.fromJson(Map<String, dynamic> json) {
    return FarmerData(
      farmer: json['farmer'] != null ? Farmer.fromJson(json['farmer']) : Farmer.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'farmer': farmer.toJson(),
    };
  }

  // Create an empty instance for cases where `data` might be null
  factory FarmerData.empty() {
    return FarmerData(farmer: Farmer.empty());
  }
}

class Farmer {
  int id;
  String uuid;
  int familyId;
  String generationId;
  int? fatherId;
  int? motherId;
  String registrationId;
  String salutationId;
  String firstName;
  String middleName;
  String lastName;
  String dateOfBirth;
  int genderId;
  String photograph;
  String mobileNumber;
  String? alternateNumber;
  String email;
  int farmerCategoryId;
  int socialCategoryId;
  int educationId;
  int religionId;
  int occupationId;
  String aadharNumber;
  String aadharCardImage;
  String panNumber;
  String voterNumber;
  String voterCardImage;
  String govtFarmerId;
  String hortnetId;
  int isCompleted;
  DateTime? registrationCompletedAt;
  int createdBy;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  int? farmerStatusId;
  int isBpl;
  int maleMembers;
  int femaleMembers;
  int isPmKishanHolder;
  String? pmKishanNumber;
  int isFinancialAssistantHolder;
  String? amount;
  String? receivedYear;
  String? schemeName;
  String familyName;
  int monthlyIncome;
  DateTime createdDate;
  Metadata metadata;
  int age;

  Farmer({
    required this.id,
    required this.uuid,
    required this.familyId,
    required this.generationId,
    this.fatherId,
    this.motherId,
    required this.registrationId,
    required this.salutationId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.genderId,
    required this.photograph,
    required this.mobileNumber,
    this.alternateNumber,
    required this.email,
    required this.farmerCategoryId,
    required this.socialCategoryId,
    required this.educationId,
    required this.religionId,
    required this.occupationId,
    required this.aadharNumber,
    required this.aadharCardImage,
    required this.panNumber,
    required this.voterNumber,
    required this.voterCardImage,
    required this.govtFarmerId,
    required this.hortnetId,
    required this.isCompleted,
    this.registrationCompletedAt,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.farmerStatusId,
    required this.isBpl,
    required this.maleMembers,
    required this.femaleMembers,
    required this.isPmKishanHolder,
    this.pmKishanNumber,
    required this.isFinancialAssistantHolder,
    this.amount,
    this.receivedYear,
    this.schemeName,
    required this.familyName,
    required this.monthlyIncome,
    required this.createdDate,
    required this.metadata,
    required this.age,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      familyId: json['family_id'] ?? 0,
      generationId: json['generation_id'] ?? '',
      fatherId: json['father_id'],
      motherId: json['mother_id'],
      registrationId: json['registration_id'] ?? '',
      salutationId: json['salutation_id'] ?? '',
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      genderId: json['gender_id'] ?? 0,
      photograph: json['photograph'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      alternateNumber: json['alternate_number'],
      email: json['email'] ?? '',
      farmerCategoryId: json['farmer_category_id'] ?? 0,
      socialCategoryId: json['social_category_id'] ?? 0,
      educationId: json['education_id'] ?? 0,
      religionId: json['religion_id'] ?? 0,
      occupationId: json['occupation_id'] ?? 0,
      aadharNumber: json['aadhar_number'] ?? '',
      aadharCardImage: json['aadhar_card_image'] ?? '',
      panNumber: json['pan_number'] ?? '',
      voterNumber: json['voter_number'] ?? '',
      voterCardImage: json['voter_card_image'] ?? '',
      govtFarmerId: json['govt_farmer_id'] ?? '',
      hortnetId: json['hortnet_id'] ?? '',
      isCompleted: json['is_completed'] ?? 0,
      registrationCompletedAt: json['registration_completed_at'] != null
          ? DateTime.parse(json['registration_completed_at'])
          : null,
      createdBy: json['created_by'] ?? 0,
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      farmerStatusId: json['farmer_status_id'],
      isBpl: json['is_bpl'] ?? 0,
      maleMembers: json['male_members'] ?? 0,
      femaleMembers: json['female_members'] ?? 0,
      isPmKishanHolder: json['is_pm_kishan_holder'] ?? 0,
      pmKishanNumber: json['pm_kishan_number'],
      isFinancialAssistantHolder: json['is_financial_assistant_holder'] ?? 0,
      amount: json['amount'],
      receivedYear: json['received_year'],
      schemeName: json['scheme_name'],
      familyName: json['family_name'] ?? '',
      monthlyIncome: json['monthly_income'] ?? 0,
      createdDate: DateTime.parse(json['created_date'] ?? ''),
      metadata: Metadata.fromJson(json['metadata'] ?? {}),
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'family_id': familyId,
      'generation_id': generationId,
      'father_id': fatherId,
      'mother_id': motherId,
      'registration_id': registrationId,
      'salutation_id': salutationId,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'gender_id': genderId,
      'photograph': photograph,
      'mobile_number': mobileNumber,
      'alternate_number': alternateNumber,
      'email': email,
      'farmer_category_id': farmerCategoryId,
      'social_category_id': socialCategoryId,
      'education_id': educationId,
      'religion_id': religionId,
      'occupation_id': occupationId,
      'aadhar_number': aadharNumber,
      'aadhar_card_image': aadharCardImage,
      'pan_number': panNumber,
      'voter_number': voterNumber,
      'voter_card_image': voterCardImage,
      'govt_farmer_id': govtFarmerId,
      'hortnet_id': hortnetId,
      'is_completed': isCompleted,
      'registration_completed_at': registrationCompletedAt?.toIso8601String(),
      'created_by': createdBy,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'farmer_status_id': farmerStatusId,
      'is_bpl': isBpl,
      'male_members': maleMembers,
      'female_members': femaleMembers,
      'is_pm_kishan_holder': isPmKishanHolder,
      'pm_kishan_number': pmKishanNumber,
      'is_financial_assistant_holder': isFinancialAssistantHolder,
      'amount': amount,
      'received_year': receivedYear,
      'scheme_name': schemeName,
      'family_name': familyName,
      'monthly_income': monthlyIncome,
      'created_date': createdDate.toIso8601String(),
      'metadata': metadata.toJson(),
      'age': age,
    };
  }

  // Create an empty instance for cases where `farmer` might be null
  factory Farmer.empty() {
    return Farmer(
      id: 0,
      uuid: '',
      familyId: 0,
      generationId: '',
      fatherId: null,
      motherId: null,
      registrationId: '',
      salutationId: '',
      firstName: '',
      middleName: '',
      lastName: '',
      dateOfBirth: '',
      genderId: 0,
      photograph: '',
      mobileNumber: '',
      alternateNumber: null,
      email: '',
      farmerCategoryId: 0,
      socialCategoryId: 0,
      educationId: 0,
      religionId: 0,
      occupationId: 0,
      aadharNumber: '',
      aadharCardImage: '',
      panNumber: '',
      voterNumber: '',
      voterCardImage: '',
      govtFarmerId: '',
      hortnetId: '',
      isCompleted: 0,
      registrationCompletedAt: null,
      createdBy: 0,
      status: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
      farmerStatusId: null,
      isBpl: 0,
      maleMembers: 0,
      femaleMembers: 0,
      isPmKishanHolder: 0,
      pmKishanNumber: null,
      isFinancialAssistantHolder: 0,
      amount: null,
      receivedYear: null,
      schemeName: null,
      familyName: '',
      monthlyIncome: 0,
      createdDate: DateTime.now(),
      metadata: Metadata.empty(),
      age: 0,
    );
  }
}

class Metadata {
  String isGovtjob;

  Metadata({required this.isGovtjob});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      isGovtjob: json['isGovtjob'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isGovtjob': isGovtjob,
    };
  }

  // Create an empty instance for cases where `metadata` might be null
  factory Metadata.empty() {
    return Metadata(isGovtjob: '0');
  }
}
