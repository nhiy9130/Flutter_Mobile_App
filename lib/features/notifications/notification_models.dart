class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.courseId,
    this.isRead = false,
    required this.createdAt,
  });
  final String id;
  final String type; // info|success|warning|error|chat|quiz|assignment|stream
  final String title;
  final String message;
  final String? courseId;
  final bool isRead;
  final DateTime createdAt;
}

class NotificationPrefs {
  const NotificationPrefs({
    this.enableSound = true,
    this.enableBrowser = false,
    this.categories = const {
      'chat': true,
      'quiz': true,
      'assignment': true,
      'stream': true,
      'announcement': true,
    },
  });
  final bool enableSound;
  final bool enableBrowser;
  final Map<String, bool> categories;
}
