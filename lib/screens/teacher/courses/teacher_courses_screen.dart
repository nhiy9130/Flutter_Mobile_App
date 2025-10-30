import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/quick_action_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../students/student_management_screen.dart';

class TeacherCoursesScreen extends ConsumerWidget {
  const TeacherCoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CommonAppBar(
        title: 'Quản lý khóa học',
        showNotificationsAction: false,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_rounded,
                color: Colors.green.shade700,
                size: 20,
              ),
            ),
            onPressed: () => context.go('/create-course'),
            tooltip: 'Tạo khóa học mới',
          ),
          const SizedBox(width: 8),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Quick Actions for Teachers
          _buildSectionHeader(
            context,
            title: 'Hành động nhanh',
            icon: Icons.bolt_rounded,
            iconColor: Colors.orange,
          ),
          const SizedBox(height: 16),
          _buildTeacherQuickActions(context),
          const SizedBox(height: 32),

          // My Active Courses
          _buildSectionHeader(
            context,
            title: 'Khóa học đang giảng dạy',
            icon: Icons.school_rounded,
            iconColor: Colors.blue,
            actionLabel: 'Xem tất cả',
            onActionTap: () {},
          ),
          const SizedBox(height: 16),
          _buildActiveCourses(context),
          const SizedBox(height: 32),

          // Draft Courses
          _buildSectionHeader(
            context,
            title: 'Khóa học nháp',
            icon: Icons.drafts_rounded,
            iconColor: Colors.grey,
          ),
          const SizedBox(height: 16),
          _buildDraftCourses(context),
          const SizedBox(height: 32),

          // Recent Activities
          _buildSectionHeader(
            context,
            title: 'Hoạt động gần đây',
            icon: Icons.history_rounded,
            iconColor: Colors.purple,
          ),
          const SizedBox(height: 16),
          _buildRecentActivities(context),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/create-course'),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Tạo khóa học',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    String? actionLabel,
    VoidCallback? onActionTap,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        if (actionLabel != null)
          TextButton(
            onPressed: onActionTap,
            child: Text(
              actionLabel,
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTeacherQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickActionCard(
            icon: Icons.announcement_rounded,
            title: 'Thông báo',
            subtitle: 'Gửi thông báo cho lớp',
            color: Colors.orange,
            onTap: () => _createAnnouncement(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickActionCard(
            icon: Icons.assessment_rounded,
            title: 'Báo cáo',
            subtitle: 'Xem thống kê lớp học',
            color: Colors.teal,
            onTap: () => _viewReports(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveCourses(BuildContext context) {
    final courses = [
      {
        'id': 'course-1',
        'title': 'Introduction to Flutter Development',
        'code': 'FLT101',
        'students': 45,
        'status': 'active',
        'progress': 0.7,
        'nextClass': '2024-10-15 14:00',
      },
      {
        'id': 'course-2',
        'title': 'Advanced Mobile Development',
        'code': 'AMD201',
        'students': 28,
        'status': 'active',
        'progress': 0.4,
        'nextClass': '2024-10-16 10:00',
      },
    ];

    return Column(
      children: courses
          .map((course) => _buildCourseCard(context, course))
          .toList(),
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.go('/teacher/courses/${course['id']}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      course['code'],
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Đang hoạt động',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                course['title'],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.people_rounded,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${course['students']} sinh viên',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.schedule_rounded,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Tiết tiếp: ${course['nextClass']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tiến độ khóa học',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: course['progress'],
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.green.shade600,
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${(course['progress'] * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _manageStudents(context, course['id']),
                      icon: const Icon(Icons.people_rounded, size: 18),
                      label: const Text('Sinh viên'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _viewGrades(context, course['id']),
                      icon: const Icon(Icons.grade_rounded, size: 18),
                      label: const Text('Điểm'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraftCourses(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: EmptyState(
          icon: Icons.drafts_rounded,
          title: 'Chưa có khóa học nháp',
          subtitle: 'Tạo khóa học mới để bắt đầu',
          actionLabel: 'Tạo khóa học',
        ),
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    final activities = [
      {
        'type': 'quiz_created',
        'title': 'Tạo quiz "Flutter Widgets"',
        'course': 'FLT101',
        'time': '2 giờ trước',
        'icon': Icons.quiz_rounded,
        'color': Colors.purple,
      },
      {
        'type': 'announcement',
        'title': 'Thông báo về deadline bài tập',
        'course': 'AMD201',
        'time': '4 giờ trước',
        'icon': Icons.announcement_rounded,
        'color': Colors.orange,
      },
      {
        'type': 'livestream',
        'title': 'Buổi live "State Management"',
        'course': 'FLT101',
        'time': '1 ngày trước',
        'icon': Icons.videocam_rounded,
        'color': Colors.red,
      },
    ];

    return Column(
      children: activities.map((activity) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (activity['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                activity['icon'] as IconData,
                color: activity['color'] as Color,
                size: 22,
              ),
            ),
            title: Text(
              activity['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${activity['course']} • ${activity['time']}',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            trailing: Icon(
              Icons.more_vert_rounded,
              color: Colors.grey.shade400,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _createAnnouncement(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Tạo thông báo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Tiêu đề',
                hintText: 'Thông báo quan trọng...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Nội dung',
                hintText: 'Nội dung thông báo...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle_rounded, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Thông báo đã được gửi!'),
                    ],
                  ),
                  backgroundColor: Colors.green.shade600,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('Gửi'),
          ),
        ],
      ),
    );
  }

  void _viewReports(BuildContext context) {
    // TODO: Navigate to reports
  }

  void _manageStudents(BuildContext context, String courseId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StudentManagementScreen(courseId: courseId),
      ),
    );
  }

  void _viewGrades(BuildContext context, String courseId) {
    context.go('/teacher/courses/$courseId/grades');
  }
}
