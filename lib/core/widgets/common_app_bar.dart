import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/notifications/notification_store.dart';

class CommonAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.elevation,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.showNotificationsAction = false,
    this.onBack,
  });

  /// Simple text title. If [titleWidget] is provided, it takes precedence.
  final String? title;

  /// Custom title widget.
  final Widget? titleWidget;

  /// Extra actions appended to the right side.
  final List<Widget>? actions;

  /// Optional bottom widget (e.g., TabBar).
  final PreferredSizeWidget? bottom;

  final Color? backgroundColor;
  final double? elevation;
  final bool? centerTitle;

  /// Whether to automatically imply a leading/back button when a Navigator can pop.
  final bool automaticallyImplyLeading;

  /// Show a notifications action with an unread badge that navigates to '/notifications-demo'.
  final bool showNotificationsAction;

  /// Optional callback to override default back behavior.
  final VoidCallback? onBack;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(notificationProvider).unreadCount;

    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: _buildLeading(context),
      actions: [
        if (actions != null) ...actions!,
        if (showNotificationsAction) _NotificationsAction(unread: unread),
      ],
      bottom: bottom,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (!automaticallyImplyLeading) return null;
    // Let AppBar decide if there's a back button; but allow override with onBack.
    if (onBack == null) return null; // Use default behavior
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack);
  }
}

class _NotificationsAction extends StatelessWidget {
  const _NotificationsAction({required this.unread});
  final int unread;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Thông báo',
      onPressed: () => context.go('/notifications-demo'),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.notifications_outlined),
          if (unread > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  unread > 99 ? '99+' : '$unread',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
