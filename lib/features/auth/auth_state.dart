import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/prefs.dart';
import '../../core/data/demo_data.dart';

class User {
  const User({required this.id, required this.email, required this.fullName, required this.role});
  final int id;
  final String email;
  final String fullName;
  final String role; // 'student' | 'instructor' | 'admin'
}

class AuthState {
  const AuthState({
    this.user,
    this.token,
    this.isLoading = false,
    this.initialized = false,
    this.error,
  });
  final User? user;
  final String? token;
  final bool isLoading;
  final bool initialized;
  final String? error;

  bool get isAuthenticated => user != null && token != null;

  AuthState copyWith({
    User? user,
    String? token,
    bool? isLoading,
    bool? initialized,
    String? error,
  }) => AuthState(
    user: user ?? this.user,
    token: token ?? this.token,
    isLoading: isLoading ?? this.isLoading,
    initialized: initialized ?? this.initialized,
    error: error,
  );
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> initializeDemo() async {
    final saved = await Prefs.loadAuth();
    if (saved.token != null && saved.user != null) {
      state = AuthState(
        user: User(
          id: saved.user!['id'] as int? ?? 1,
          email: saved.user!['email'] as String? ?? 'user@example.com',
          fullName: saved.user!['fullName'] as String? ?? 'Demo User',
          role: saved.user!['role'] as String? ?? 'student',
        ),
        token: saved.token,
        initialized: true,
      );
    } else {
      state = state.copyWith(initialized: true);
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(milliseconds: 800));

    // Try demo accounts first
    final demoUser = DemoAccounts.authenticate(email, password);
    if (demoUser != null) {
      state = AuthState(user: demoUser, token: 'demo-token-${demoUser.id}', initialized: true);
      await Prefs.saveAuth(
        token: 'demo-token-${demoUser.id}',
        user: {
          'id': demoUser.id,
          'email': demoUser.email,
          'fullName': demoUser.fullName,
          'role': demoUser.role,
        },
      );
      return true;
    }

    // Fallback: any email/password returns a mock user
    state = AuthState(
      user: User(id: 1, email: email, fullName: 'Demo User', role: 'student'),
      token: 'demo-token',
      initialized: true,
    );
    await Prefs.saveAuth(
      token: 'demo-token',
      user: {'id': 1, 'email': email, 'fullName': 'Demo User', 'role': 'student'},
    );
    return true;
  }

  Future<void> logout() async {
    state = state.copyWith(user: null, token: null);
    await Prefs.clearAuth();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
