import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/auth_state.dart';
import '../../features/courses/courses_service.dart';
import 'package:go_router/go_router.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key, this.myCoursesOnly = false});
  final bool myCoursesOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final future = myCoursesOnly
        ? coursesService.getMyCourses(auth.user?.id ?? 0, auth.user?.role ?? 'student')
        : coursesService.getAllCourses();

    return Scaffold(
      appBar: AppBar(title: Text(myCoursesOnly ? 'My Courses' : 'Courses')),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final courses = snapshot.data!;
          if (courses.isEmpty) {
            return const Center(child: Text('No Courses'));
          }
          return ListView.separated(
            itemCount: courses.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final c = courses[index];
              return ListTile(
                title: Text(c.title),
                subtitle: Text(c.description),
                trailing: Text('${c.enrollmentCount}'),
                onTap: () {
                  context.go('/courses/${c.id}');
                },
              );
            },
          );
        },
      ),
    );
  }
}


