
class FarmarDetailModel {
  final bool status;
  final int statusCode;
  final Data data;

  FarmarDetailModel({
    required this.status,
    required this.statusCode,
    required this.data,
  });

  factory FarmarDetailModel.fromJson(Map<String, dynamic> json) {
    return FarmarDetailModel(
      status: json['status'],
      statusCode: json['statusCode'],
      data: Data.fromJson(json['data']),


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'data': data.toJson(),
    };
  }
}

class Data {
  final List<Country> countryList;
  final List<State> stateList;
  final List<District> districtList;
  final List<Block> blockList;
  final List<Vcdc> vcdcList;
  final List<RevenueVillage> revenueVillageList;
  final List<Gender> genders;
  final List<FarmerCategory> farmerCategories;
  final List<SocialCategory> socialCategories;
  final List<Education> educations;
  final List<Religion> religions;
  final List<Occupation> occupations;
  // final List<Relation> relations;
  final FamilyLists familyLists;
  // final List<Status> statuses;
  final List<Salutation> salutations;
  final List<BplStatus> bplStatuses;
  final List<PmKishan> pmKishans;
  final List<Income> incomes;

  Data({
    required this.countryList,
    required this.stateList,
    required this.districtList,
    required this.blockList,
    required this.vcdcList,
    required this.revenueVillageList,
    required this.genders,
    required this.farmerCategories,
    required this.socialCategories,
    required this.educations,
    required this.religions,
    required this.occupations,
    // required this.relations,
    required this.familyLists,
    // required this.statuses,
    required this.salutations,
    required this.bplStatuses,
    required this.pmKishans,
    required this.incomes,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      countryList: (json['countryList'] as List)
          .map((i) => Country.fromJson(i))
          .toList(),
      stateList: (json['stateList'] as List)
          .map((i) => State.fromJson(i))
          .toList(),
      districtList: (json['districtList'] as List)
          .map((i) => District.fromJson(i))
          .toList(),
      blockList: (json['blockList'] as List)
          .map((i) => Block.fromJson(i))
          .toList(),
      vcdcList: (json['vcdcList'] as List)
          .map((i) => Vcdc.fromJson(i))
          .toList(),
      revenueVillageList: (json['revenueVillageList'] as List)
          .map((i) => RevenueVillage.fromJson(i))
          .toList(),
      genders: (json['genders'] as List)
          .map((i) => Gender.fromJson(i))
          .toList(),
      farmerCategories: (json['farmerCategories'] as List)
          .map((i) => FarmerCategory.fromJson(i))
          .toList(),
      socialCategories: (json['socialCategories'] as List)
          .map((i) => SocialCategory.fromJson(i))
          .toList(),
      educations: (json['educations'] as List)
          .map((i) => Education.fromJson(i))
          .toList(),
      religions: (json['religions'] as List)
          .map((i) => Religion.fromJson(i))
          .toList(),
      occupations: (json['occupations'] as List)
          .map((i) => Occupation.fromJson(i))
          .toList(),
      // relations: (json['relations'] as List)
      //     .map((i) => Relation.fromJson(i))
      //     .toList(),
      familyLists: FamilyLists.fromJson(json['familyLists']),
      // statuses: (json['statuses'] as List)
      //     .map((i) => Status.fromJson(i))
      //     .toList(),
      salutations: (json['salutations'] as List)
          .map((i) => Salutation.fromJson(i))
          .toList(),
      bplStatuses: (json['bplStatuses'] as List)
          .map((i) => BplStatus.fromJson(i))
          .toList(),
      pmKishans: (json['pmKishans'] as List)
          .map((i) => PmKishan.fromJson(i))
          .toList(),
      incomes: (json['incomes'] as List)
          .map((i) => Income.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countryList': countryList.map((e) => e.toJson()).toList(),
      'stateList': stateList.map((e) => e.toJson()).toList(),
      'districtList': districtList.map((e) => e.toJson()).toList(),
      'blockList': blockList.map((e) => e.toJson()).toList(),
      'vcdcList': vcdcList.map((e) => e.toJson()).toList(),
      'revenueVillageList': revenueVillageList.map((e) => e.toJson()).toList(),
      'genders': genders.map((e) => e.toJson()).toList(),
      'farmerCategories': farmerCategories.map((e) => e.toJson()).toList(),
      'socialCategories': socialCategories.map((e) => e.toJson()).toList(),
      'educations': educations.map((e) => e.toJson()).toList(),
      'religions': religions.map((e) => e.toJson()).toList(),
      'occupations': occupations.map((e) => e.toJson()).toList(),
      // 'relations': relations.map((e) => e.toJson()).toList(),
      'familyLists': familyLists.toJson(),
      // 'statuses': statuses.map((e) => e.toJson()).toList(),
      'salutations': salutations.map((e) => e.toJson()).toList(),
      'bplStatuses': bplStatuses.map((e) => e.toJson()).toList(),
      'pmKishans': pmKishans.map((e) => e.toJson()).toList(),
      'incomes': incomes.map((e) => e.toJson()).toList(),
    };
  }
}

class Country {
  final int id;
  final String name;
  final String code;
  final List<State> states;

  Country({
    required this.id,
    required this.name,
    required this.code,
    required this.states,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      states: (json['states'] as List)
          .map((i) => State.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'states': states.map((e) => e.toJson()).toList(),
    };
  }
}

class State {
  final int id;
  final String name;
  final String code;
  final int countryId;

  State({
    required this.id,
    required this.name,
    required this.code,
    required this.countryId,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      countryId: json['country_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'country_id': countryId,
    };
  }
}

class District {
  final int id;
  final String name;
  final String code;
  final List<Block> blocks;

  District({
    required this.id,
    required this.name,
    required this.code,
    required this.blocks,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      blocks: (json['blocks'] as List)
          .map((i) => Block.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'blocks': blocks.map((e) => e.toJson()).toList(),
    };
  }
}

class Block {
  final int id;
  final String name;
  final String code;
  final List<Vcdc> vcdcs;

  Block({
    required this.id,
    required this.name,
    required this.code,
    required this.vcdcs,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      vcdcs: (json['vcdcs'] as List)
          .map((i) => Vcdc.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'vcdcs': vcdcs.map((e) => e.toJson()).toList(),
    };
  }
}

class Vcdc {
  final int id;
  final String name;
  final String code;
  final List<RevenueVillage> revenueVillages;

  Vcdc({
    required this.id,
    required this.name,
    required this.code,
    required this.revenueVillages,
  });

  factory Vcdc.fromJson(Map<String, dynamic> json) {
    return Vcdc(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      revenueVillages: (json['revenueVillages'] as List)
          .map((i) => RevenueVillage.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'revenueVillages': revenueVillages.map((e) => e.toJson()).toList(),
    };
  }
}

class RevenueVillage {
  final int id;
  final int vcdcId;
  final String name;
  final String code;

  RevenueVillage({
    required this.id,
    required this.vcdcId,
    required this.name,
    required this.code,
  });

  factory RevenueVillage.fromJson(Map<String, dynamic> json) {
    return RevenueVillage(
      id: json['id'],
      vcdcId: json['vcdc_id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vcdc_id': vcdcId,
      'name': name,
      'code': code,
    };
  }
}

class Gender {
  final String name;
  final String code;

  Gender({
    required this.name,
    required this.code,
  });

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}

class FarmerCategory {
  final String name;
  final String code;

  FarmerCategory({
    required this.name,
    required this.code,
  });

  factory FarmerCategory.fromJson(Map<String, dynamic> json) {
    return FarmerCategory(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}

class SocialCategory {
  final String name;
  final String code;

  SocialCategory({
    required this.name,
    required this.code,
  });

  factory SocialCategory.fromJson(Map<String, dynamic> json) {
    return SocialCategory(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}

class Education {
  final int id;
  final String name;
  final String code;

  Education({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }
}

class Religion {
  final int id;
  final String name;
  final String code;

  Religion({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }
}

class Occupation {
  final int id;
  final String name;
  final String code;

  Occupation({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) {
    return Occupation(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
    };
  }
}

class Relation {
  // Define fields for Relation if available
}

class FamilyLists {
  final int currentPage;
  final List<dynamic> data;
  final String firstPageUrl;
  final dynamic from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final dynamic nextPageUrl;
  final String path;
  final int perPage;
  final dynamic prevPageUrl;
  final dynamic to;
  final int total;

  FamilyLists({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory FamilyLists.fromJson(Map<String, dynamic> json) {
    return FamilyLists(
      currentPage: json['current_page'],
      data: json['data'],
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List)
          .map((i) => Link.fromJson(i))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data,
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links.map((e) => e.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class Status {
  // Define fields for Status if available
}

class Salutation {
  final int id;
  final String name;

  Salutation({
    required this.id,
    required this.name,
  });

  factory Salutation.fromJson(Map<String, dynamic> json) {
    return Salutation(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class BplStatus {
  final String name;
  final int code;

  BplStatus({
    required this.name,
    required this.code,
  });

  factory BplStatus.fromJson(Map<String, dynamic> json) {
    return BplStatus(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}

class PmKishan {
  final String name;
  final int code;

  PmKishan({
    required this.name,
    required this.code,
  });

  factory PmKishan.fromJson(Map<String, dynamic> json) {
    return PmKishan(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}

class Income {
  final String name;
  final String code;

  Income({
    required this.name,
    required this.code,
  });

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}
