import 'course_model.dart';

class CoursesService {
  Future<List<Course>> getAllCourses() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _demoCourses;
  }

  Future<List<Course>> getMyCourses(int userId, String role) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Demo: return subset
    return _demoCourses.take(2).toList();
  }

  Future<Course?> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _demoCourses.where((c) => c.id == id).cast<Course?>().firstOrNull;
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}

const List<Course> _demoCourses = [
  Course(
    id: '1',
    title: 'Introduction to React Development',
    description: 'Learn React fundamentals: components, hooks, state.',
    code: 'CS101',
    instructorName: 'Dr. John Smith',
    thumbnailUrl: null,
    enrollmentCount: 23,
  ),
  Course(
    id: '2',
    title: 'Advanced JavaScript Concepts',
    description: 'Closures, prototypes, async programming, ES6+.',
    code: 'CS201',
    instructorName: 'Prof. Sarah Wilson',
    thumbnailUrl: null,
    enrollmentCount: 18,
  ),
  Course(
    id: '3',
    title: 'Full-Stack Web Development',
    description: 'Frontend + Backend with Node.js, React, DBs.',
    code: 'CS301',
    instructorName: 'Dr. John Smith',
    thumbnailUrl: null,
    enrollmentCount: 35,
  ),
];

final coursesService = CoursesService();



