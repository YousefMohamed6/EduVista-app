import '../../../../shared/utils/constants/firestore_keys.dart';
import '../../domain/entities/instructor.dart';

class InstructorModel extends Instructor {
  InstructorModel({
    required super.id,
    required super.name,
    required super.education,
    super.image,
    required super.yearsOfExperience,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'] ?? '',
      name: json[FirestoreKeys.name] ?? '',
      education: json[FirestoreKeys.education] ?? '',
      image: json[FirestoreKeys.image],
      yearsOfExperience: (json[FirestoreKeys.yearsOfExperience] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      FirestoreKeys.name: name,
      FirestoreKeys.education: education,
      FirestoreKeys.image: image,
      FirestoreKeys.yearsOfExperience: yearsOfExperience,
    };
  }
}
