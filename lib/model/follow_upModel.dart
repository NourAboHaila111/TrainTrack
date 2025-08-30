class FollowUp {
  final int id;
  final int followerid;
  final String? response; // الرسالة أو الرد
  final int status;       // 0: Open, 1: In Progress, 2: Closed
  final int sectionId;
  final String? sectionName;
  final String? createdAt;
  final String? updatedAt;

  FollowUp({
    required this.id,
    required this.followerid,
    this.response,
    required this.status,
    required this.sectionId,
    this.sectionName,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowUp.fromJson(Map<String, dynamic> json) {
    return FollowUp(
      id: json['id'] ?? 0,
      response: json['response'] ?? '',
      status: json['status'] ?? 0,
      sectionId: json['section_id'] ?? 0,
      sectionName: json['section']['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'], followerid:json['follower_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'response': response,
      'status': status,
      'section_id': sectionId,
      'section_name': sectionName,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'follower_id':followerid,
    };
  }
}
