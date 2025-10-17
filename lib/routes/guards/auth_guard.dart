import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/auth_state.dart';

String? requireAuth(BuildContext context, GoRouterState state) {
  // Access Riverpod container through context (GoRouter provides BuildContext)
  try {
    final container = ProviderScope.containerOf(context, listen: false);
    final auth = container.read(authProvider);
    return auth.isAuthenticated ? null : '/login';
  } catch (_) {
    return null;
  }
}
