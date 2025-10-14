import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/auth_state.dart';
import '../../core/data/demo_data.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('auth.login.title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showDemoAccountsDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Demo banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Demo Mode: Tap the info icon to see demo accounts',
                      style: TextStyle(color: Colors.blue.shade700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: tr('auth.login.email'),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: tr('auth.login.password'),
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                        setState(() => loading = true);
                        final ok = await ref.read(authProvider.notifier).login(emailCtrl.text, passCtrl.text);
                        setState(() => loading = false);
                        if (ok && mounted) context.go('/dashboard');
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(tr('auth.login.submit'), style: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            // Quick login buttons
            Text(
              'Quick Login:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            _buildQuickLoginButton(
              context,
              'Student Account',
              'student@demo.com',
              'student123',
              Icons.school,
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildQuickLoginButton(
              context,
              'Instructor Account',
              'instructor@demo.com',
              'instructor123',
              Icons.person,
              Colors.green,
            ),
            const SizedBox(height: 8),
            _buildQuickLoginButton(
              context,
              'Admin Account',
              'admin@demo.com',
              'admin123',
              Icons.admin_panel_settings,
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLoginButton(
    BuildContext context,
    String label,
    String email,
    String password,
    IconData icon,
    Color color,
  ) {
    return OutlinedButton.icon(
      onPressed: () {
        emailCtrl.text = email;
        passCtrl.text = password;
      },
      icon: Icon(icon, color: color),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _showDemoAccountsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demo Accounts'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DemoAccounts.getAccountInfo(),
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

