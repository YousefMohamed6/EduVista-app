import 'package:edu_vista/src/shared/utils/constants/firestore_keys.dart';

class Instructor {
  final String id;
  final String name;
  final String education;
  final String? image;
  final int yearsOfExperience;

  Instructor({
    required this.id,
    required this.name,
    required this.education,
    this.image,
    required this.yearsOfExperience,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'] ?? '',
      name: json[FirestoreKeys.name] ?? '',
      education: json[FirestoreKeys.education] ?? '',
      image: json[FirestoreKeys.image],
      yearsOfExperience:
          (json[FirestoreKeys.yearsOfExperience] as num?)?.toInt() ?? 0,
    );
  }
}
