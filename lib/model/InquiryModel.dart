// models/inquiry_model.dart

class Inquiry {
  final int id;
  final String title;
  final String? body;
  final String status;
  final String category;
  final String user;
  final String? assignee;

  Inquiry({
    required this.id,
    required this.title,
    this.body,
    required this.status,
    required this.category,
    required this.user,
    this.assignee,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    return Inquiry(
      id: json['id'],
      title: json['title'] ?? '',
      body: json['body'],
      status: json['status']?['name'] ?? 'N/A',
      category: json['category']?['name'] ?? 'Unknown',
      user: json['user']?['name'] ?? 'Unknown',
      assignee: json['assignee_user']?['name'],
    );
  }
}
