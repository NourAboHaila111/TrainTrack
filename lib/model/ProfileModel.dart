// model/profile_model.dart
class ProfileModel {
  final int id;
  final String name;
  final String email;
  final int roleId;
  final int sectionId;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    required this.sectionId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roleId: json['role_id'],
      sectionId: json['section_id'],
    );
  }
}
