class Farmersingledetail {
  final bool status;
  final int statusCode;
  final List<FarmerData> data;

  Farmersingledetail({
    required this.status,
    required this.statusCode,
    required this.data,
  });

  factory Farmersingledetail.fromJson(Map<String, dynamic> json) {
    return Farmersingledetail(
      status: json['status'],
      statusCode: json['statusCode'],
      data: (json['data'] as List).map((i) => FarmerData.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'data': data.map((i) => i.toJson()).toList(),
    };
  }
}

class FarmerData {
  final int id;
  final String isHead;
  final String registrationId;
  final String fullName;
  final int age;
  final String dateOfBirth;
  final String gender;
  final String photograph;
  final String mobileNumber;
  final String? alternateNumber;
  final String email;
  final String farmerCategory;
  final String socialCategory;
  final String education;
  final String religion;
  final String occupation;
  final String govtId;
  final String panNumber;
  final String aadharWithMusk;
  final String aadharWithoutMusk;
  final String horticultureId;
  final String relation;
  final String status;
  final String isBpl;
  final int? maleMembers;
  final int? femaleMembers;
  final String isPmKishan;
  final String? pmKishanNumber;
  final int totalMember;
  final String monthlyIncome;
  final dynamic metadata;
  final String? aadharCardImage;
  final String? voterCardImage;
  final Address address;
  final List<dynamic> land;
  final List<dynamic> agris;
  final int stat;

  FarmerData({
    required this.id,
    required this.isHead,
    required this.registrationId,
    required this.fullName,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.photograph,
    required this.mobileNumber,
    this.alternateNumber,
    required this.email,
    required this.farmerCategory,
    required this.socialCategory,
    required this.education,
    required this.religion,
    required this.occupation,
    required this.govtId,
    required this.panNumber,
    required this.aadharWithMusk,
    required this.aadharWithoutMusk,
    required this.horticultureId,
    required this.relation,
    required this.status,
    required this.isBpl,
    this.maleMembers,
    this.femaleMembers,
    required this.isPmKishan,
    this.pmKishanNumber,
    required this.totalMember,
    required this.monthlyIncome,
    this.metadata,
    this.aadharCardImage,
    this.voterCardImage,
    required this.address,
    required this.land,
    required this.agris,
    required this.stat,
  });

  factory FarmerData.fromJson(Map<String, dynamic> json) {
    return FarmerData(
      id: json['id'],
      isHead: json['isHead'],
      registrationId: json['registration_id'],
      fullName: json['full_name'],
      age: json['age'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      photograph: json['photograph'],
      mobileNumber: json['mobile_number'],
      alternateNumber: json['alternate_number'],
      email: json['email'],
      farmerCategory: json['farmer_category'],
      socialCategory: json['social_category'],
      education: json['education'],
      religion: json['religion'],
      occupation: json['occupation'],
      govtId: json['govt_id'],
      panNumber: json['pan_number'],
      aadharWithMusk: json['aadhar_with_musk'],
      aadharWithoutMusk: json['aadhar_without_musk'],
      horticultureId: json['horticulture_id'],
      relation: json['relation'],
      status: json['status'],
      isBpl: json['is_bpl'],
      maleMembers: json['male_members'],
      femaleMembers: json['female_members'],
      isPmKishan: json['is_pm_kishan'],
      pmKishanNumber: json['pm_kishan_number'],
      totalMember: json['total_member'],
      monthlyIncome: json['monthly_income'],
      metadata: json['metadata'],
      aadharCardImage: json['aadhar_card_image'],
      voterCardImage: json['voter_card_image'],
      address: Address.fromJson(json['address']),
      land: json['land'] ?? [],
      agris: json['agris'] ?? [],
      stat: json['stat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isHead': isHead,
      'registration_id': registrationId,
      'full_name': fullName,
      'age': age,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'photograph': photograph,
      'mobile_number': mobileNumber,
      'alternate_number': alternateNumber,
      'email': email,
      'farmer_category': farmerCategory,
      'social_category': socialCategory,
      'education': education,
      'religion': religion,
      'occupation': occupation,
      'govt_id': govtId,
      'pan_number': panNumber,
      'aadhar_with_musk': aadharWithMusk,
      'aadhar_without_musk': aadharWithoutMusk,
      'horticulture_id': horticultureId,
      'relation': relation,
      'status': status,
      'is_bpl': isBpl,
      'male_members': maleMembers,
      'female_members': femaleMembers,
      'is_pm_kishan': isPmKishan,
      'pm_kishan_number': pmKishanNumber,
      'total_member': totalMember,
      'monthly_income': monthlyIncome,
      'metadata': metadata,
      'aadhar_card_image': aadharCardImage,
      'voter_card_image': voterCardImage,
      'address': address.toJson(),
      'land': land,
      'agris': agris,
      'stat': stat,
    };
  }
}

class Address {
  final String addressLine1;
  final String addressLine2;
  final String country;
  final String state;
  final String district;
  final String block;
  final String vcdc;
  final String revenueVillage;
  final String pincode;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.country,
    required this.state,
    required this.district,
    required this.block,
    required this.vcdc,
    required this.revenueVillage,
    required this.pincode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      country: json['country'],
      state: json['state'],
      district: json['district'],
      block: json['block'],
      vcdc: json['vcdc'],
      revenueVillage: json['revenue_village'],
      pincode: json['pincode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'country': country,
      'state': state,
      'district': district,
      'block': block,
      'vcdc': vcdc,
      'revenue_village': revenueVillage,
      'pincode': pincode,
    };
  }
}
