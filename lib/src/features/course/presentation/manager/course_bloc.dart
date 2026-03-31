import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/utils/app_enums.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';

// Events
abstract class CourseEvent {}
class GetCoursesEvent extends CourseEvent {
  final String? rank;
  final String? categoryId;
  final String? instructorId;
  GetCoursesEvent({this.rank, this.categoryId, this.instructorId});
}
class CourseFetchEvent extends CourseEvent {
  final Course course;
  CourseFetchEvent(this.course);
}
class GetRecentlyWatchedCoursesEvent extends CourseEvent {}
class AddCourseToRvEvent extends CourseEvent {
  final Course course;
  AddCourseToRvEvent(this.course);
}
class CourseOptionChosenEvent extends CourseEvent {
  final CourseOptions courseOptions;
  CourseOptionChosenEvent(this.courseOptions);
}

// States
abstract class CourseState {}
class CourseInitial extends CourseState {}
class CourseLoading extends CourseState {}
class CoursesLoaded extends CourseState {
  final List<Course> courses;
  CoursesLoaded(this.courses);
}
class CourseDetailsLoaded extends CourseState {
  final Course course;
  CourseDetailsLoaded(this.course);
}
class CourseRecentlyWatchedLoaded extends CourseState {
  final List<Course> recentlyWatchedCourses;
  CourseRecentlyWatchedLoaded(this.recentlyWatchedCourses);
}
class CourseOptionStateChanges extends CourseState {
  final CourseOptions courseOption;
  CourseOptionStateChanges(this.courseOption);
}
class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}

// Bloc implementation
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository _courseRepository;
  Course? course; // changed from currentCourse to maintain existing UI compatibility

  CourseBloc(this._courseRepository) : super(CourseInitial()) {
    on<GetCoursesEvent>((event, emit) async {
      emit(CourseLoading());
      try {
        final courses = await _courseRepository.getCourses(
          rank: event.rank,
          categoryId: event.categoryId,
          instructorId: event.instructorId,
        );
        emit(CoursesLoaded(courses));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });

    on<CourseFetchEvent>((event, emit) {
      course = event.course;
      emit(CourseDetailsLoaded(event.course));
      // By default show detail option (intro/lesson etc) or wait for choice
      add(CourseOptionChosenEvent(CourseOptions.Lecture));
    });

    on<GetRecentlyWatchedCoursesEvent>((event, emit) async {
      try {
        final courses = await _courseRepository.getRecentlyViewedCourses();
        emit(CourseRecentlyWatchedLoaded(courses));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });

    on<AddCourseToRvEvent>((event, emit) async {
      try {
        await _courseRepository.addCourseToRecentlyViewed(event.course);
        add(GetRecentlyWatchedCoursesEvent());
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });

    on<CourseOptionChosenEvent>((event, emit) {
      emit(CourseOptionStateChanges(event.courseOptions));
    });
  }
}
