class NotificationModel {
  final int id;
  final int inquiryId;
  final int userId;
  final String title;
  final String message;
  final String status; // 'read' أو 'unread'
  final String createdAt;
  final String updatedAt;
  final String? userName;

  NotificationModel({
    required this.id,
    required this.inquiryId,
    required this.userId,
    required this.title,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.userName,
  });

  bool get isRead => status == 'read';

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch,
      inquiryId: json['inquiry_id'],
      userId: json['user_id'],
      title: json['title'] ?? 'بدون عنوان',
      message: json['message'] ?? '',
      status: json['status'] ?? 'unread',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      userName: json['user_name'], // optional
    );
  }
}
