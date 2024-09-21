


class Assetsdetialmodel {
  // bool status;
  // int statusCode;
  // String message;
  LandData data;

  Assetsdetialmodel({
    // required this.status,
    // required this.statusCode,
    // required this.message,
    required this.data,
  });

  factory Assetsdetialmodel.fromJson(Map<String, dynamic> json) {
    return Assetsdetialmodel(
      // status: json['status'],
      // statusCode: json['statusCode'],
      // message: json['message'],
      data: LandData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'status': status,
      // 'statusCode': statusCode,
      // 'message': message,
      'data': data.toJson(),
    };
  }
}

class LandData {

  List<Land> lands;
  String? farmerUuid;

  LandData({
    required this.lands,
    required this.farmerUuid,
  });

  factory LandData.fromJson(Map<String, dynamic> json) {
    var landList = (json['lands'] as List).map((i) => Land.fromJson(i)).toList();
    return LandData(
      lands: landList,
      farmerUuid: json['farmer_uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lands': lands.map((land) => land.toJson()).toList(),
      'farmer_uuid': farmerUuid,
    };
  }
}

class Land {
  String? uuid;
  String? firstName;
  String? middleName;
  String? lastName;
  double? plot;
  int? plotInBigha;
  String? ownership;
  String? typeOfLand;
  String? status;
  String? statusColor;
  Address? address;

  Land({
    required this.uuid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.plot,
    required this.plotInBigha,
    required this.ownership,
    required this.typeOfLand,
    required this.status,
    required this.statusColor,
    required this.address,
  });

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      uuid: json['uuid'],
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      plot: json['plot'],
      plotInBigha: json['plot_in_bigha'],
      ownership: json['ownership'],
      typeOfLand: json['type_of_land'],
      status: json['status'],
      statusColor: json['status_color'],
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'plot': plot,
      'plot_in_bigha': plotInBigha,
      'ownership': ownership,
      'type_of_land': typeOfLand,
      'status': status,
      'status_color': statusColor,
      'address': address?.toJson(),
    };
  }
}

class Address {
  String? country;
  String? state;
  String? district;
  String? block;
  String? vcdc;
  String? line1;
  String? line2;
  String? revenueVillage;

  Address({
    required this.country,
    required this.state,
    required this.district,
    required this.block,
    required this.vcdc,
    required this.line1,
    required this.line2,
    required this.revenueVillage,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'],
      state: json['state'],
      district: json['district'],
      block: json['block'],
      vcdc: json['vcdc'],
      line1: json['line_1'],
      line2: json['line_2'],
      revenueVillage: json['revenue_village'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'state': state,
      'district': district,
      'block': block,
      'vcdc': vcdc,
      'line_1': line1,
      'line_2': line2,
      'revenue_village': revenueVillage,
    };
  }
}
