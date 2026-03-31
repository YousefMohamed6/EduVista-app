import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/src/shared/utils/constants/firestore_keys.dart';
import 'package:edu_vista/src/features/instructor/domain/entities/instructor.dart';

class Course {
  final String id;
  final String title;
  final String image;
  final String? description;
  final double? price;
  final double? rating;
  final Instructor? instructor;
  final DateTime? createdDate;
  final String? rank;
  final String? resource;
  final bool hasBought;

  Course({
    required this.id,
    required this.title,
    required this.image,
    this.description,
    this.price,
    this.rating,
    this.instructor,
    this.createdDate,
    this.rank,
    this.resource,
    this.hasBought = false,
  });

  Course copyWith({
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
    return Course(
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

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      title: json[FirestoreKeys.title] ?? '',
      image: json[FirestoreKeys.image] ?? '',
      description: json[FirestoreKeys.description],
      price: (json[FirestoreKeys.price] as num?)?.toDouble(),
      rating: (json[FirestoreKeys.rating] as num?)?.toDouble(),
      instructor: json[FirestoreKeys.instructor] != null
          ? (json[FirestoreKeys.instructor] is Map<String, dynamic>
              ? Instructor.fromJson(json[FirestoreKeys.instructor])
              : null)
          : null,
      createdDate: json[FirestoreKeys.createdDate] != null
          ? (json[FirestoreKeys.createdDate] is Timestamp
              ? (json[FirestoreKeys.createdDate] as Timestamp).toDate()
              : (json[FirestoreKeys.createdDate] is String
                  ? DateTime.tryParse(json[FirestoreKeys.createdDate])
                  : null))
          : null,
      rank: json[FirestoreKeys.rank],
      resource: json[FirestoreKeys.resource],
      hasBought: json['has_bought'] ?? false,
    );
  }
}
