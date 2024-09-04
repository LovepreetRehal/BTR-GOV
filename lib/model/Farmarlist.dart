class Farmarlist {
  FamilyLists familyLists;

  Farmarlist({
    required this.familyLists,
  });

  factory Farmarlist.fromJson(Map<String, dynamic> json) {
    return Farmarlist(
      familyLists: FamilyLists.fromJson(json['familyLists']),
    );
  }
}

class FamilyLists {
  int currentPage;
  List<Map<String, dynamic>> data;
  String firstPageUrl;
  int from;
  int lastPage;

  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  FamilyLists({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory FamilyLists.fromJson(Map<String, dynamic> json) {
    return FamilyLists(
      currentPage: json['current_page'],
      data: List<Map<String, dynamic>>.from(
        json['data'].map(
          (item) => Map<String, dynamic>.from(item),
        ),
      ),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}
