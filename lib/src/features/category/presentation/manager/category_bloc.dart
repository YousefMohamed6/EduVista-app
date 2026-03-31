import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

// Events
abstract class CategoryEvent {}
class GetCategoriesEvent extends CategoryEvent {}

// States
abstract class CategoryState {}
class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}
class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  CategoryLoaded(this.categories);
}
class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}

// Bloc
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await _categoryRepository.getCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
