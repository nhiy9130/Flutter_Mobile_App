import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/auth_state.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr('auth.register.title'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: tr('auth.register.fullName')),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: tr('auth.register.email')),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: tr('auth.register.password')),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Demo: reuse login flow
                  await ref.read(authProvider.notifier).login(emailCtrl.text, passCtrl.text);
                  if (mounted) context.go('/dashboard');
                },
                child: Text(tr('auth.register.submit')),
              ),
            )
          ],
        ),
      ),
    );
  }
}


