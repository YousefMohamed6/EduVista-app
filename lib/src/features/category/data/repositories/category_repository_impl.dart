import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../shared/utils/constants/app_constants.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Category>> getCategories() async {
    final snapshot = await _firestore.collection(AppConstants.categoriesCollection).get();
    return snapshot.docs
        .map((doc) => CategoryModel.fromJson({'id': doc.id, ...doc.data()}))
        .toList();
  }
}
