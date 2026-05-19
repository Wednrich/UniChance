class Program {
  const Program({
    required this.id,
    required this.universityId,
    required this.name,
    required this.code,
    required this.groupCode,
    required this.profileSubjects,
    required this.grantPassingScore,
    required this.paidMinimumScore,
    required this.tuitionFee,
    required this.source,
    required this.dataYear,
  });

  final String id;
  final String universityId;
  final String name;
  final String code;
  final String groupCode;
  final List<String> profileSubjects;
  final int? grantPassingScore;
  final int paidMinimumScore;
  final int tuitionFee;
  final String source;
  final int dataYear;

  String get subjectsLabel => profileSubjects.join(' + ');

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] as String,
      universityId: json['universityId'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      groupCode: json['groupCode'] as String,
      profileSubjects: List<String>.from(json['profileSubjects'] as List),
      grantPassingScore: json['grantPassingScore'] as int?,
      paidMinimumScore: json['paidMinimumScore'] as int,
      tuitionFee: json['tuitionFee'] as int,
      source: json['source'] as String,
      dataYear: json['dataYear'] as int,
    );
  }
}
