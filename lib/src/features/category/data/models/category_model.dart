import '../../../../shared/utils/constants/firestore_keys.dart';
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json[FirestoreKeys.id] ?? '',
      name: json[FirestoreKeys.name] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreKeys.id: id,
      FirestoreKeys.name: name,
    };
  }
}
