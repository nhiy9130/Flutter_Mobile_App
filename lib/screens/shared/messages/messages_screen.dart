import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/common_app_bar.dart';
import 'conversation_list_screen.dart';

class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Tin nhắn',
        showNotificationsAction: false,
        actions: [
          IconButton(
            tooltip: 'Tạo cuộc trò chuyện',
            icon: const Icon(Icons.create_outlined),
            onPressed: () {
              // TODO: Mở màn hình chọn người/khóa học để tạo chat mới
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tạo tin nhắn mới (coming soon)')),
              );
            },
          ),
        ],
      ),
      body: const ConversationListScreen(),
    );
  }
}
