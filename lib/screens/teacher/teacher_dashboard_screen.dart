import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/widgets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../features/auth/auth_state.dart';

class TeacherDashboardScreen extends ConsumerWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildSliverAppBar(context, auth),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            // TODO: Refresh dashboard data
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Stats
                _buildTeachingStats(),
                const SizedBox(height: AppSpacing.lg),
                
                // Quick Actions
                _buildQuickActions(context),
                const SizedBox(height: AppSpacing.lg),
                
                // My Courses
                _buildMyCourses(context),
                const SizedBox(height: AppSpacing.lg),
                
                // Recent Students
                _buildRecentStudents(),
                const SizedBox(height: AppSpacing.lg),
                
                // Pending Reviews
                _buildPendingReviews(context),
                const SizedBox(height: AppSpacing.lg),
                
                // Teaching Performance
                _buildTeachingPerformance(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to create course
        },
        icon: const Icon(Icons.add),
        label: const Text('Tạo khóa học'),
        backgroundColor: AppColors.teacherPrimary,
        foregroundColor: AppColors.white,
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AuthState auth) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Teacher Dashboard',
          style: AppTypography.h5.copyWith(color: AppColors.white),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: AppColors.teacherGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.screenHorizontal,
              right: AppSpacing.screenHorizontal,
              bottom: AppSpacing.xl,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.white.withOpacity(0.2),
                      child: Icon(
                        Icons.school,
                        color: AppColors.white,
                        size: AppSizes.iconLg,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Xin chào, ${auth.user?.fullName}',
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          'Giảng viên · 5 khóa học',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeachingStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thống kê giảng dạy',
          style: AppTypography.h6,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Học viên',
                '342',
                Icons.people,
                AppColors.primary,
                '+23 tuần này',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                'Khóa học',
                '5',
                Icons.school,
                AppColors.teacherPrimary,
                '2 đang hoạt động',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Đánh giá',
                '4.9',
                Icons.star,
                AppColors.warning,
                '124 đánh giá',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                'Thu nhập',
                '₫45M',
                Icons.monetization_on,
                AppColors.success,
                'Tháng này',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: AppSizes.iconMd,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.trending_up,
                  size: AppSizes.iconSm,
                  color: AppColors.success,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.grey600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              style: AppTypography.h5.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.grey600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thao tác nhanh',
          style: AppTypography.h6,
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.5,
          children: [
            _buildActionCard(
              'Tạo bài học',
              Icons.video_library,
              AppColors.primary,
              () {},
            ),
            _buildActionCard(
              'Xem báo cáo',
              Icons.analytics,
              AppColors.accent,
              () {},
            ),
            _buildActionCard(
              'Quản lý học viên',
              Icons.people_alt,
              AppColors.secondary,
              () {},
            ),
            _buildActionCard(
              'Tin nhắn',
              Icons.message,
              AppColors.warning,
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return CustomCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Icon(
                icon,
                color: color,
                size: AppSizes.iconLg,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyCourses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Khóa học của tôi',
              style: AppTypography.h6,
            ),
            TextButton(
              onPressed: () => context.go('/teacher/courses'),
              child: Text(
                'Xem tất cả',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.teacherPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index < 2 ? AppSpacing.md : 0,
                ),
                child: _buildCourseCard(index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(int index) {
    final courses = [
      {
        'title': 'Flutter Development',
        'students': 89,
        'progress': 0.75,
        'status': 'active',
        'color': AppColors.primary,
      },
      {
        'title': 'React Native Basics',
        'students': 156,
        'progress': 1.0,
        'status': 'completed',
        'color': AppColors.secondary,
      },
      {
        'title': 'Mobile UI/UX Design',
        'students': 67,
        'progress': 0.45,
        'status': 'draft',
        'color': AppColors.accent,
      },
    ];

    final course = courses[index];
    return SizedBox(
      width: 200,
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: (course['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(
                  Icons.play_circle,
                  color: course['color'] as Color,
                  size: AppSizes.iconMd,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                course['title'] as String,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${course['students']} học viên',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.grey600,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${((course['progress'] as double) * 100).toInt()}%',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _buildStatusBadge(course['status'] as String),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String text;
    switch (status) {
      case 'active':
        color = AppColors.success;
        text = 'Hoạt động';
        break;
      case 'completed':
        color = AppColors.primary;
        text = 'Hoàn thành';
        break;
      case 'draft':
        color = AppColors.warning;
        text = 'Nháp';
        break;
      default:
        color = AppColors.grey500;
        text = 'Khác';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Text(
        text,
        style: AppTypography.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildRecentStudents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Học viên gần đây',
          style: AppTypography.h6,
        ),
        const SizedBox(height: AppSpacing.md),
        CustomCard(
          child: Column(
            children: [
              _buildStudentItem(
                'Nguyễn Văn A',
                'Flutter Development',
                '85%',
                AppColors.success,
                'assets/images/avatar1.png',
              ),
              const Divider(height: 1),
              _buildStudentItem(
                'Trần Thị B',
                'React Native Basics',
                '92%',
                AppColors.success,
                'assets/images/avatar2.png',
              ),
              const Divider(height: 1),
              _buildStudentItem(
                'Lê Văn C',
                'Mobile UI/UX Design',
                '67%',
                AppColors.warning,
                'assets/images/avatar3.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStudentItem(
    String name,
    String course,
    String progress,
    Color progressColor,
    String avatar,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.grey200,
            child: Text(
              name[0].toUpperCase(),
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  course,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: progressColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              progress,
              style: AppTypography.bodySmall.copyWith(
                color: progressColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingReviews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cần xem xét',
              style: AppTypography.h6,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Xem tất cả',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.teacherPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        CustomCard(
          child: Column(
            children: [
              _buildReviewItem(
                'Bài tập tuần 3',
                '12 bài nộp chưa chấm',
                Icons.assignment,
                AppColors.warning,
                () {},
              ),
              const Divider(height: 1),
              _buildReviewItem(
                'Q&A mới',
                '8 câu hỏi chưa trả lời',
                Icons.help_outline,
                AppColors.primary,
                () {},
              ),
              const Divider(height: 1),
              _buildReviewItem(
                'Yêu cầu chứng chỉ',
                '5 yêu cầu chờ duyệt',
                Icons.verified,
                AppColors.accent,
                () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                icon,
                color: color,
                size: AppSizes.iconSm,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.grey600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.grey400,
              size: AppSizes.iconSm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeachingPerformance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hiệu suất giảng dạy',
          style: AppTypography.h6,
        ),
        const SizedBox(height: AppSpacing.md),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                _buildPerformanceMetric(
                  'Tỷ lệ hoàn thành',
                  '87%',
                  0.87,
                  AppColors.success,
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildPerformanceMetric(
                  'Tương tác học viên',
                  '92%',
                  0.92,
                  AppColors.primary,
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildPerformanceMetric(
                  'Phản hồi tích cực',
                  '95%',
                  0.95,
                  AppColors.accent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceMetric(
    String title,
    String percentage,
    double value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.bodyMedium,
            ),
            Text(
              percentage,
              style: AppTypography.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LinearProgressIndicator(
          value: value,
          backgroundColor: AppColors.grey200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
        ),
      ],
    );
  }
}