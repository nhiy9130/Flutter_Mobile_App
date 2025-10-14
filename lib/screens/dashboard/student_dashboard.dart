import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/auth_state.dart';
import '../../core/widgets/quick_action_card.dart';
import '../../core/widgets/stat_card.dart';
import '../../core/widgets/progress_card.dart';
import '../../core/widgets/section_header.dart';
import '../../features/recommendations/recommendation_service.dart';
import '../../features/analytics/learning_analytics_service.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Welcome Section
        _buildWelcomeCard(context),
        const SizedBox(height: 24),

        // Quick Actions
        const SectionHeader(
          title: 'Truy cập nhanh',
          icon: Icons.flash_on,
        ),
        const SizedBox(height: 12),
        _buildQuickActions(context),
        const SizedBox(height: 24),

        // Learning Progress
        const SectionHeader(
          title: 'Tiến độ học tập',
          action: 'Xem tất cả',
        ),
        const SizedBox(height: 12),
        _buildLearningProgress(context),
        const SizedBox(height: 24),

        // Analytics
        const SectionHeader(
          title: 'Thống kê',
          icon: Icons.analytics,
        ),
        const SizedBox(height: 12),
        _buildAnalytics(context),
        const SizedBox(height: 24),

        // Recommendations
        const SectionHeader(
          title: 'Gợi ý cho bạn',
          icon: Icons.recommend,
        ),
        const SizedBox(height: 12),
        _buildRecommendations(context),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    final theme = Theme.of(context);
    final hour = DateTime.now().hour;
    String greeting = 'Chào buổi sáng';
    if (hour >= 12 && hour < 18) greeting = 'Chào buổi chiều';
    if (hour >= 18) greeting = 'Chào buổi tối';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting, ${user.fullName}! 👋',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sẵn sàng để học tập hôm nay chưa?',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => context.go('/my-courses'),
            icon: const Icon(Icons.school),
            label: const Text('Xem khóa học của tôi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.1,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        QuickActionCard(
          icon: Icons.menu_book,
          title: 'Khóa học',
          subtitle: '15 khóa học',
          color: Colors.blue,
          onTap: () => context.go('/my-courses'),
        ),
        QuickActionCard(
          icon: Icons.notifications_active,
          title: 'Thông báo',
          subtitle: '5 thông báo mới',
          color: Colors.orange,
          badge: '5',
          onTap: () => context.go('/notifications-demo'),
        ),
        QuickActionCard(
          icon: Icons.videocam,
          title: 'Live Streams',
          subtitle: '2 buổi học trực tuyến',
          color: Colors.red,
          onTap: () => context.go('/my-courses'),
        ),
        QuickActionCard(
          icon: Icons.quiz,
          title: 'Bài tập',
          subtitle: '3 bài tập chưa nộp',
          color: Colors.purple,
          badge: '3',
          onTap: () => context.go('/my-courses'),
        ),
      ],
    );
  }

  Widget _buildLearningProgress(BuildContext context) {
    return Column(
      children: [
        ProgressCard(
          title: 'Introduction to Flutter Development',
          subtitle: 'TS. Trần Thị Bình • 12/15 bài học',
          progress: 0.8,
          color: Colors.blue,
          onTap: () => context.go('/courses/course-1'),
        ),
        const SizedBox(height: 8),
        ProgressCard(
          title: 'Advanced React & TypeScript',
          subtitle: 'Dr. John Smith • 8/20 bài học',
          progress: 0.4,
          color: Colors.green,
          onTap: () => context.go('/courses/course-2'),
        ),
        const SizedBox(height: 8),
        ProgressCard(
          title: 'Data Science with Python',
          subtitle: 'Prof. Sarah Johnson • 3/18 bài học',
          progress: 0.17,
          color: Colors.purple,
          onTap: () => context.go('/courses/course-3'),
        ),
      ],
    );
  }

  Widget _buildAnalytics(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        StatCard(
          icon: Icons.access_time,
          value: '124h',
          label: 'Thời gian học',
          color: Colors.blue,
          trend: '+12%',
          trendUp: true,
        ),
        StatCard(
          icon: Icons.assignment_turned_in,
          value: '89%',
          label: 'Điểm trung bình',
          color: Colors.green,
          trend: '+5%',
          trendUp: true,
        ),
        StatCard(
          icon: Icons.local_fire_department,
          value: '15',
          label: 'Chuỗi ngày học',
          color: Colors.orange,
          trend: '+3',
          trendUp: true,
        ),
        StatCard(
          icon: Icons.emoji_events,
          value: '12',
          label: 'Thành tích',
          color: Colors.purple,
          trend: '+2',
          trendUp: true,
        ),
      ],
    );
  }

  Widget _buildRecommendations(BuildContext context) {
    return Column(
      children: [
        _buildRecommendationCard(
          context,
          'UI/UX Design Fundamentals',
          'Dựa trên sở thích của bạn',
          Icons.design_services,
          Colors.pink,
        ),
        const SizedBox(height: 8),
        _buildRecommendationCard(
          context,
          'Mobile App Development',
          'Phù hợp với kỹ năng hiện tại',
          Icons.phone_android,
          Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context,
    String title,
    String reason,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(reason),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Navigate to course detail
        },
      ),
    );
  }
}