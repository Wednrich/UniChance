class University {
  const University({
    required this.id,
    required this.name,
    required this.city,
    required this.type,
    required this.website,
    required this.hasMilitaryDepartment,
    required this.hasDormitory,
  });

  final String id;
  final String name;
  final String city;
  final String type;
  final String website;
  final bool hasMilitaryDepartment;
  final bool hasDormitory;

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      type: json['type'] as String,
      website: json['website'] as String,
      hasMilitaryDepartment: json['hasMilitaryDepartment'] as bool,
      hasDormitory: json['hasDormitory'] as bool,
    );
  }
}
