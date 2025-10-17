import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Common imports
import '../screens/common/home_screen.dart';
import '../screens/common/root_shell.dart';
import '../screens/common/not_found_screen.dart';
import '../screens/common/auth/login_screen.dart';
import '../screens/common/auth/register_screen.dart';
import '../screens/common/auth/forgot_password_screen.dart';

// Shared imports
import '../screens/shared/profile/profile_screen.dart';
import '../screens/shared/settings/settings_screen.dart';
import '../screens/shared/notifications/notifications_screen.dart';
import '../screens/shared/livestream/livestream_screen.dart';
import '../screens/shared/dashboard/dashboard_dispatcher.dart';

// Student imports
import '../screens/student/courses/student_courses_screen.dart';
import '../screens/student/courses/course_detail/course_detail_screen.dart';

import 'guards/auth_guard.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
      GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordScreen()),

      ShellRoute(
        builder: (context, state, child) => RootShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) => const DashboardDispatcher(),
          ),
          GoRoute(
            path: '/my-courses',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) => const StudentCoursesScreen(myCoursesOnly: true),
          ),
          GoRoute(
            path: '/courses/:courseId',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) =>
                CourseDetailScreen(courseId: state.pathParameters['courseId']!),
          ),
          GoRoute(
            path: '/course/:id',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) => CourseDetailScreen(courseId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/course/:id/live',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) => LiveStreamScreen(courseId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: '/notifications-demo',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) => const NotificationsScreen(),
          ),
          GoRoute(
            path: '/settings',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: '/profile',
            redirect: (context, state) => requireAuth(context, state),
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
