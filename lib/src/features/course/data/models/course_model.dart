import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/src/features/course/domain/entities/course.dart';
import 'package:edu_vista/src/features/instructor/data/models/instructor_model.dart';
import 'package:edu_vista/src/features/instructor/domain/entities/instructor.dart';
import 'package:edu_vista/src/shared/utils/constants/firestore_keys.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.title,
    required super.image,
    super.description,
    super.price,
    super.rating,
    super.instructor,
    super.createdDate,
    super.rank,
    super.resource,
    super.hasBought,
  });

  @override
  CourseModel copyWith({
    String? id,
    String? title,
    String? image,
    String? description,
    double? price,
    double? rating,
    Instructor? instructor,
    DateTime? createdDate,
    String? rank,
    String? resource,
    bool? hasBought,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      instructor: instructor ?? this.instructor,
      createdDate: createdDate ?? this.createdDate,
      rank: rank ?? this.rank,
      resource: resource ?? this.resource,
      hasBought: hasBought ?? this.hasBought,
    );
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json[FirestoreKeys.title] ?? '',
      image: json[FirestoreKeys.image] ?? '',
      description: json[FirestoreKeys.description],
      price: (json[FirestoreKeys.price] as num?)?.toDouble(),
      rating: (json[FirestoreKeys.rating] as num?)?.toDouble(),
      instructor: json[FirestoreKeys.instructor] != null
          ? (json[FirestoreKeys.instructor] is Map<String, dynamic>
              ? InstructorModel.fromJson(json[FirestoreKeys.instructor])
              : null)
          : null,
      createdDate: json[FirestoreKeys.createdDate] != null
          ? (json[FirestoreKeys.createdDate] as Timestamp).toDate()
          : null,
      rank: json[FirestoreKeys.rank],
      resource: json[FirestoreKeys.resource],
      hasBought: json['has_bought'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreKeys.title: title,
      FirestoreKeys.image: image,
      FirestoreKeys.description: description,
      FirestoreKeys.price: price,
      FirestoreKeys.rating: rating,
      FirestoreKeys.instructor: instructor != null && instructor is InstructorModel
          ? (instructor as InstructorModel).toJson()
          : null,
      FirestoreKeys.createdDate: createdDate != null
          ? Timestamp.fromDate(createdDate!)
          : null,
      FirestoreKeys.rank: rank,
      FirestoreKeys.resource: resource,
      'has_bought': hasBought,
    };
  }
}
