import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/auth/auth_state.dart';
import '../../student/dashboard/student_dashboard.dart';
import '../../teacher/dashboard/teacher_dashboard.dart';
import '../../admin/dashboard/admin_dashboard.dart';

/// Dispatcher to show correct dashboard based on user role
class DashboardDispatcher extends ConsumerWidget {
  const DashboardDispatcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.user;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    switch (user.role) {
      case 'student':
        return StudentDashboard(user: user);
      case 'teacher' || 'instructor':
        return TeacherDashboard(user: user);
      case 'admin':
        return AdminDashboard(user: user);
      default:
        return const Scaffold(body: Center(child: Text('Unknown user role')));
    }
  }
}
