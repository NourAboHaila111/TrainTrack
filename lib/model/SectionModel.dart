class SectionModel {
  final int id;
  final String name;
  final String division;

  SectionModel({required this.id, required this.name, required this.division});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      name: json['name'],
      division: json['division'],
    );
  }
}
