class Inquiry {
  final int id;
  final String title;
  final String body;
  final String? response;
  final String statusName;
  final String categoryName;

  Inquiry({
    required this.id,
    required this.title,
    required this.body,
    this.response,
    required this.statusName,
    required this.categoryName,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    return Inquiry(
      id: json['id'],
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      response: json['response'],
      statusName: json['cur_status_id'].toString(), // يفضل تحويله لاسم من API
      categoryName: json['category_id'].toString(), // نفس الشي
    );
  }
}

class Favourite {
  final int id;
  final int inquiryId;
  final Inquiry inquiry;

  Favourite({
    required this.id,
    required this.inquiryId,
    required this.inquiry,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return Favourite(
      id: json['id'],
      inquiryId: json['inquiry_id'],
      inquiry: Inquiry.fromJson(json['inquiry']),
    );
  }
}
