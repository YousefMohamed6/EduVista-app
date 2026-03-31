import '../entities/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses({String? rank, String? categoryId, String? instructorId});
  Future<List<Course>> getRecentlyViewedCourses();
  Future<void> addCourseToRecentlyViewed(Course course);
}
