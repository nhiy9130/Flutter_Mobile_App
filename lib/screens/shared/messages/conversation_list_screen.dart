import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../features/chat/chat_store.dart';
import '../../../core/widgets/empty_state.dart';

class ConversationListScreen extends ConsumerStatefulWidget {
  const ConversationListScreen({super.key});

  @override
  ConsumerState<ConversationListScreen> createState() =>
      _ConversationListScreenState();
}

class _ConversationListScreenState
    extends ConsumerState<ConversationListScreen> {
  final TextEditingController _searchCtl = TextEditingController();

  @override
  void dispose() {
    _searchCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = ref.watch(chatProvider);
    final query = _searchCtl.text.trim().toLowerCase();

    final entries = chat.messagesByCourse.entries.toList()
      ..sort((a, b) {
        final ta = a.value.isNotEmpty
            ? a.value.last.timestamp
            : DateTime.fromMillisecondsSinceEpoch(0);
        final tb = b.value.isNotEmpty
            ? b.value.last.timestamp
            : DateTime.fromMillisecondsSinceEpoch(0);
        return tb.compareTo(ta);
      });

    final filtered = query.isEmpty
        ? entries
        : entries.where((e) {
            final courseId = e.key.toLowerCase();
            final lastMsg = (e.value.isNotEmpty ? e.value.last.message : '')
                .toLowerCase();
            return courseId.contains(query) || lastMsg.contains(query);
          }).toList();

    if (filtered.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _searchBar(),
            const SizedBox(height: 16),
            const EmptyState(
              icon: Icons.chat_bubble_outline,
              title: 'Chưa có hội thoại',
              subtitle: 'Bắt đầu trò chuyện trong một khóa học để hiện ở đây.',
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _seedDemo(ref),
              icon: const Icon(Icons.bolt),
              label: const Text('Tạo dữ liệu demo'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      itemCount: filtered.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _searchBar(),
          );
        }
        final e = filtered[index - 1];
        final courseId = e.key;
        final last = e.value.isNotEmpty ? e.value.last : null;
        final preview = last?.message ?? 'Chưa có tin nhắn';
        final time = last?.timestamp;

        final unread = 0; // TODO: bổ sung logic unread nếu có

        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              child: Icon(
                Icons.group,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(
              'Khóa học $courseId',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              preview,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatTime(time),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                if (unread > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            onTap: () => context.go('/messages/$courseId'),
          ),
        );
      },
    );
  }

  // Thanh tìm kiếm
  Widget _searchBar() {
    return TextField(
      controller: _searchCtl,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Tìm kiếm hội thoại...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        isDense: true,
      ),
    );
  }

  // Tạo dữ liệu mẫu
  void _seedDemo(WidgetRef ref) {
    final notifier = ref.read(chatProvider.notifier);
    notifier.sendMessage('FLT101', 101, 'Bạn', 'Xin chào lớp FLT101 👋');
    notifier.sendMessage(
      'FLT101',
      1,
      'Dr. John Smith',
      'Chào em, hôm nay chúng ta học Widgets.',
    );

    notifier.sendMessage(
      'AMD201',
      102,
      'Bạn',
      'Mọi người xem tài liệu buổi 5 chưa?',
    );
    notifier.sendMessage(
      'AMD201',
      2,
      'Jane Doe',
      'Mình thấy phần state management khá hay.',
    );

    notifier.sendMessage(
      'DS301',
      103,
      'Bạn',
      'Deadline bài tập tuần này là khi nào vậy ạ?',
    );
    notifier.sendMessage('DS301', 1, 'Dr. John Smith', 'Chủ nhật 23:59 nhé.');
  }

  String _formatTime(DateTime? t) {
    if (t == null) return '';
    final now = DateTime.now();
    final diff = now.difference(t);
    if (diff.inMinutes < 1) return 'Vừa xong';
    if (diff.inHours < 1) return '${diff.inMinutes}p';
    if (diff.inHours < 24) return '${diff.inHours}g';
    return '${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}';
  }
}
