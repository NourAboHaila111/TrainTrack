// class Inquiry {
//   final int id;
//   final int userId;
//   final int assigneeId;
//   final int categoryId;
//   final int curStatusId;
//   final String title;
//   final String body;
//   final String? response;
//   final String? closedAt;
//   final String? deletedAt;
//   final String createdAt;
//   final String updatedAt;
//
//   final String userName;
//   final String assigneeName;
//   final String categoryName;
//   final String statusName;
//
//   bool isFavourite;
//
//   Inquiry({
//     required this.id,
//     required this.userId,
//     required this.assigneeId,
//     required this.categoryId,
//     required this.curStatusId,
//     required this.title,
//     required this.body,
//     this.response,
//     this.closedAt,
//     this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.userName,
//     required this.assigneeName,
//     required this.categoryName,
//     required this.statusName,
//     this.isFavourite = false,
//   });
//
//   factory Inquiry.fromJson(Map<String, dynamic> json) {
//     final inquiry = json['inquiry'] ?? json;
//
//     return Inquiry(
//       id: inquiry['id'],
//       userId: inquiry['user_id'],
//       assigneeId: inquiry['assignee_id'],
//       categoryId: inquiry['category_id'],
//       curStatusId: inquiry['cur_status_id'],
//       title: inquiry['title'] ?? '',
//       body: inquiry['body'] ?? '',
//       response: inquiry['response'],
//       closedAt: inquiry['closed_at'],
//       deletedAt: inquiry['deleted_at'],
//       createdAt: inquiry['created_at'] ?? '',
//       updatedAt: inquiry['updated_at'] ?? '',
//       userName: inquiry['user']?['name'] ?? json['user']?['name'] ?? '',
//       assigneeName: inquiry['assignee_user']?['name'] ??
//           json['assigneeUser']?['name'] ??
//           '',
//       categoryName: inquiry['category']?['name'] ?? json['category']?['name'] ?? '',
//       statusName: inquiry['status']?['name'] ?? json['status']?['name'] ?? '',
//       isFavourite: (json['favourited'] == 1),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'assignee_id': assigneeId,
//       'category_id': categoryId,
//       'cur_status_id': curStatusId,
//       'title': title,
//       'body': body,
//       'response': response,
//       'closed_at': closedAt,
//       'deleted_at': deletedAt,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'user': {'name': userName},
//       'assignee_user': {'name': assigneeName},
//       'category': {'name': categoryName},
//       'status': {'name': statusName},
//       'favourited': isFavourite ? 1 : 0,
//     };
//   }
// }
class Inquiry {
  final int id;
  final int userId;
  final int assigneeId;
  final int categoryId;
  final int curStatusId;
  final String title;
  final String body;
  final String? response;
  final String? assingee;
  final String? closedAt;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;

  final String userName;
  final String assigneeName;
  final String categoryName;
  final String statusName;

  final List<Attachment> attachments;
  bool isFavourite;

  Inquiry({
    required this.id,
    required this.userId,
    required this.assigneeId,
    required this.categoryId,
    required this.curStatusId,
    required this.title,
    required this.body,
    this.response,
    this.closedAt,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.assigneeName,
    required this.categoryName,
    required this.statusName,
    this.attachments = const [],
    this.isFavourite = false,
    this.assingee,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    final inquiry = json['inquiry'] ?? json;

    return Inquiry(
      id: inquiry['id'],
      userId: inquiry['user_id'] ?? 0,
      assigneeId: inquiry['assignee_id'] ?? 0,
      categoryId: inquiry['category_id'] ?? 0,
      curStatusId: inquiry['cur_status_id'] ?? 0,
      title: inquiry['title'] ?? '',
      body: inquiry['body'] ?? '',
      response: inquiry['response'],
      closedAt: inquiry['closed_at'],
      deletedAt: inquiry['deleted_at'],
      createdAt: inquiry['created_at'] ?? '',
      updatedAt: inquiry['updated_at'] ?? '',
      userName: inquiry['user']?['name'] ?? '',
      assingee: inquiry['assignee_user']?['name'] ?? '',
      assigneeName: inquiry['assignee_user']?['name'] ?? '',
      categoryName: inquiry['category']?['name'] ?? '',
      statusName: inquiry['status']?['name'] ?? 'unread',
      isFavourite: (json['favourited'] == 1),
      attachments: (inquiry['attachments'] as List<dynamic>? ?? [])
          .map((a) => Attachment.fromJson(a))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'assignee_id': assigneeId,
      'category_id': categoryId,
      'cur_status_id': curStatusId,
      'title': title,
      'body': body,
      'response': response,
      'closed_at': closedAt,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': {'name': userName},
      'assignee_user': {'name': assigneeName},
      'category': {'name': categoryName},
      'status': {'name': statusName},
      'favourited': isFavourite ? 1 : 0,
      'attachments': attachments.map((a) => a.toJson()).toList(),
    };
  }

  // ✅ نسخة copyWith لتجنب تمرير كل الحقول يدويًا
  Inquiry copyWith({
    int? id,
    int? userId,
    int? assigneeId,
    int? categoryId,
    int? curStatusId,
    String? title,
    String? body,
    String? response,
    String? closedAt,
    String? deletedAt,
    String? createdAt,
    String? updatedAt,
    String? userName,
    String? assigneeName,
    String? categoryName,
    String? statusName,
    List<Attachment>? attachments,
    bool? isFavourite,
  }) {
    return Inquiry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      assigneeId: assigneeId ?? this.assigneeId,
      categoryId: categoryId ?? this.categoryId,
      curStatusId: curStatusId ?? this.curStatusId,
      title: title ?? this.title,
      body: body ?? this.body,
      response: response ?? this.response,
      closedAt: closedAt ?? this.closedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userName: userName ?? this.userName,
      assigneeName: assigneeName ?? this.assigneeName,
      categoryName: categoryName ?? this.categoryName,
      statusName: statusName ?? this.statusName,
      attachments: attachments ?? this.attachments,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}

class Attachment {
  final int id;
  final String fileUrl;
  final String type;

  Attachment({
    required this.id,
    required this.fileUrl,
    required this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      fileUrl: json['file_url'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_url': fileUrl,
      'type': type,
    };
  }
}
