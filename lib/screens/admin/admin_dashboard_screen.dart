import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/widgets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
import '../../features/auth/auth_state.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

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
                _buildQuickStats(),
                const SizedBox(height: AppSpacing.lg),
                
                // Quick Actions
                _buildQuickActions(context),
                const SizedBox(height: AppSpacing.lg),
                
                // Recent Activity
                _buildRecentActivity(),
                const SizedBox(height: AppSpacing.lg),
                
                // System Overview
                _buildSystemOverview(),
                const SizedBox(height: AppSpacing.lg),
                
                // User Management
                _buildUserManagement(context),
                const SizedBox(height: AppSpacing.lg),
                
                // Course Management
                _buildCourseManagement(context),
              ],
            ),
          ),
        ),
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
          'Admin Dashboard',
          style: AppTypography.h5.copyWith(color: AppColors.white),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: AppColors.adminGradient,
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
                        Icons.admin_panel_settings,
                        color: AppColors.white,
                        size: AppSizes.iconLg,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chào mừng, ${auth.user?.fullName}',
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          'Quản trị hệ thống LMS',
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

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tổng quan hệ thống',
          style: AppTypography.h6,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Tổng người dùng',
                '1,247',
                Icons.people,
                AppColors.primary,
                '+12% so với tháng trước',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                'Khóa học',
                '156',
                Icons.school,
                AppColors.secondary,
                '+8 khóa học mới',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Doanh thu',
                '₫125M',
                Icons.trending_up,
                AppColors.success,
                '+15% so với tháng trước',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                'Đánh giá',
                '4.8',
                Icons.star,
                AppColors.warning,
                'Đánh giá trung bình',
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
                color: AppColors.success,
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
              'Quản lý người dùng',
              Icons.people_alt,
              AppColors.primary,
              () => context.go('/admin/users'),
            ),
            _buildActionCard(
              'Quản lý khóa học',
              Icons.school,
              AppColors.secondary,
              () => context.go('/admin/courses'),
            ),
            _buildActionCard(
              'Báo cáo doanh thu',
              Icons.analytics,
              AppColors.accent,
              () => context.go('/admin/reports'),
            ),
            _buildActionCard(
              'Cài đặt hệ thống',
              Icons.settings,
              AppColors.grey600,
              () => context.go('/admin/settings'),
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

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hoạt động gần đây',
              style: AppTypography.h6,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Xem tất cả',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        CustomCard(
          child: Column(
            children: [
              _buildActivityItem(
                'Người dùng mới đăng ký',
                'Nguyễn Văn A đã đăng ký tài khoản',
                Icons.person_add,
                AppColors.success,
                '5 phút trước',
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Khóa học mới được tạo',
                'Flutter Advanced được thêm bởi GV. Trần',
                Icons.add_circle,
                AppColors.primary,
                '1 giờ trước',
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Thanh toán thành công',
                'Học viên ABC đã thanh toán khóa ReactJS',
                Icons.payment,
                AppColors.success,
                '2 giờ trước',
              ),
              const Divider(height: 1),
              _buildActivityItem(
                'Báo cáo sự cố',
                'Lỗi video không phát được báo cáo',
                Icons.report_problem,
                AppColors.error,
                '3 giờ trước',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    String title,
    String description,
    IconData icon,
    Color iconColor,
    String time,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              icon,
              color: iconColor,
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
          Text(
            time,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.grey500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tình trạng hệ thống',
          style: AppTypography.h6,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildSystemStatusCard(
                'Server Status',
                'Online',
                AppColors.success,
                Icons.cloud_done,
                '99.9% Uptime',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildSystemStatusCard(
                'Database',
                'Optimal',
                AppColors.success,
                Icons.storage,
                '145ms Response',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildSystemStatusCard(
                'CDN',
                'Active',
                AppColors.warning,
                Icons.language,
                '89% Cache Hit',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildSystemStatusCard(
                'Backup',
                'Completed',
                AppColors.success,
                Icons.backup,
                '2 hours ago',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemStatusCard(
    String title,
    String status,
    Color statusColor,
    IconData icon,
    String detail,
  ) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: statusColor,
                  size: AppSizes.iconMd,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    status,
                    style: AppTypography.bodySmall.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              detail,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.grey600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserManagement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quản lý người dùng',
              style: AppTypography.h6,
            ),
            TextButton.icon(
              onPressed: () => context.go('/admin/users'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Chi tiết'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                _buildUserStat('Học viên', '1,089', '+12', AppColors.primary),
                const SizedBox(height: AppSpacing.md),
                _buildUserStat('Giảng viên', '45', '+2', AppColors.secondary),
                const SizedBox(height: AppSpacing.md),
                _buildUserStat('Quản trị viên', '8', '0', AppColors.accent),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserStat(String role, String count, String change, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            Icons.person,
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
                role,
                style: AppTypography.bodyMedium,
              ),
              Text(
                count,
                style: AppTypography.h6.copyWith(
                  fontWeight: FontWeight.bold,
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
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            '+$change',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseManagement(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quản lý khóa học',
              style: AppTypography.h6,
            ),
            TextButton.icon(
              onPressed: () => context.go('/admin/courses'),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Chi tiết'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                _buildCourseStat(
                  'Đang hoạt động',
                  '142',
                  AppColors.success,
                  Icons.play_circle,
                ),
                const Divider(height: AppSpacing.lg),
                _buildCourseStat(
                  'Chờ duyệt',
                  '8',
                  AppColors.warning,
                  Icons.pending,
                ),
                const Divider(height: AppSpacing.lg),
                _buildCourseStat(
                  'Đã tạm dừng',
                  '6',
                  AppColors.error,
                  Icons.pause_circle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseStat(
    String status,
    String count,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: AppSizes.iconMd,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            status,
            style: AppTypography.bodyMedium,
          ),
        ),
        Text(
          count,
          style: AppTypography.h6.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}