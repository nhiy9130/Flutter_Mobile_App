import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/auth_state.dart';
// import '../../../core/widgets/quick_action_card.dart';
import '../../../core/widgets/custom_cards.dart' as cc;
import '../../../core/widgets/progress_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/info_card.dart';
import '../../../core/widgets/advanced_info_card.dart';
import '../../../core/widgets/badges.dart';

class TeacherDashboard extends ConsumerWidget {
  const TeacherDashboard({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        // Welcome Section
        _buildWelcomeCard(context),
        const SizedBox(height: 32),

        // Teaching Stats
        const SectionHeader(
          title: 'Thống kê giảng dạy',
          icon: Icons.analytics_rounded,
        ),
        const SizedBox(height: 16),
        _buildTeachingStats(context),
        const SizedBox(height: 32),

        // My Courses
        SectionHeader(
          title: 'Khóa học của tôi',
          icon: Icons.school_rounded,
          action: 'Quản lý tất cả',
          onActionPressed: () => context.go('/teacher-courses'),
        ),
        const SizedBox(height: 16),
        _buildMyCourses(context),
        const SizedBox(height: 32),

        // Recent Activities
        const SectionHeader(
          title: 'Hoạt động gần đây',
          icon: Icons.history_rounded,
        ),
        const SizedBox(height: 16),
        _buildRecentActivities(context),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return AdvancedInfoCard(
      leadingIcon: Icons.person_rounded,
      title: 'Chào ${user.fullName}! 👨‍🏫',
      subtitle: 'Sẵn sàng truyền cảm hứng học tập hôm nay!',
      gradientColors: [Colors.green.shade600, Colors.teal.shade600],
      primaryActionLabel: 'Quản lý khóa học',
      primaryActionIcon: Icons.school_rounded,
      onPrimaryAction: () => context.go('/teacher-courses'),
      secondaryActionLabel: 'Tạo khóa học',
      secondaryActionIcon: Icons.add_rounded,
      onSecondaryAction: () => context.go('/create-course'),
      accentColor: Colors.green.shade700,
    );
  }

  Widget _buildMyCourses(BuildContext context) {
    return Column(
      children: [
        ProgressCard(
          title: 'Introduction to Flutter Development',
          subtitle: '45 sinh viên • 15 bài học',
          progress: 1.0,
          color: Colors.blue,
          trailing: const StatusBadge(
            label: 'Đang diễn ra',
            color: Colors.green,
            variant: BadgeVariant.subtle,
            showDot: true,
          ),
          onTap: () => context.go('/courses/course-1'),
        ),
        const SizedBox(height: 12),
        ProgressCard(
          title: 'Advanced Mobile Development',
          subtitle: '28 sinh viên • 20 bài học',
          progress: 0.6,
          color: Colors.green,
          trailing: const StatusBadge(
            label: 'Chuẩn bị',
            color: Colors.blue,
            variant: BadgeVariant.subtle,
          ),
          onTap: () => context.go('/courses/course-2'),
        ),
      ],
    );
  }

  Widget _buildTeachingStats(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.15,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: const [
        cc.StatCard(
          title: 'Khóa học',
          value: '2',
          icon: Icons.school_rounded,
          valueColor: Colors.blue,
        ),
        cc.StatCard(
          title: 'Sinh viên',
          value: '73',
          icon: Icons.people_rounded,
          valueColor: Colors.green,
          trend: cc.TrendDirection.up,
          trendValue: '+5',
        ),
        cc.StatCard(
          title: 'Đánh giá TB',
          value: '4.8',
          icon: Icons.star_rounded,
          valueColor: Colors.orange,
          trend: cc.TrendDirection.up,
          trendValue: '+0.2',
        ),
        cc.StatCard(
          title: 'Bài tập đã chấm',
          value: '156',
          icon: Icons.assignment_turned_in_rounded,
          valueColor: Colors.purple,
          trend: cc.TrendDirection.up,
          trendValue: '+12',
        ),
      ],
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    return Column(
      children: [
        _buildActivityCard(
          icon: Icons.quiz_rounded,
          iconColor: Colors.green,
          title: 'Quiz "Flutter Basics" đã được tạo',
          subtitle: '2 giờ trước • Flutter Development',
          trailing: '12 sinh viên đã làm bài',
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          icon: Icons.message_rounded,
          iconColor: Colors.blue,
          title: 'Thông báo về deadline bài tập',
          subtitle: '4 giờ trước • Advanced Mobile Dev',
          trailing: 'Đã xem: 28/28',
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          icon: Icons.videocam_rounded,
          iconColor: Colors.purple,
          title: 'Buổi livestream "State Management"',
          subtitle: '1 ngày trước • 45 người tham gia',
          trailing: null,
          trailingIcon: Icons.play_circle_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildActivityCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? trailing,
    IconData? trailingIcon,
  }) {
    return InfoCard(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: title,
      subtitle: subtitle,
      trailing: trailing != null
          ? Text(
              trailing,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            )
          : (trailingIcon != null
                ? Icon(trailingIcon, color: Colors.grey.shade400)
                : null),
    );
  }
}
