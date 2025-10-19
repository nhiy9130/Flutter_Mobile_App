import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import '../../../features/courses/courses_service.dart';
import '../../../features/courses/course_model.dart';
import '../quiz/quiz_creation_screen.dart';

// Mock data model for course content
class Lecture {
  final String title;
  final String type; // 'video', 'article', 'quiz'
  final String duration;
  Lecture({required this.title, required this.type, required this.duration});
}

class CourseSection {
  final String title;
  final List<Lecture> lectures;
  CourseSection({required this.title, required this.lectures});
}

class TeacherCourseDetailScreen extends StatefulWidget {
  final Course course;

  const TeacherCourseDetailScreen({super.key, required this.course});

  @override
  State<TeacherCourseDetailScreen> createState() =>
      _TeacherCourseDetailScreenState();
}

class _TeacherCourseDetailScreenState extends State<TeacherCourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<CourseSection> _courseContent = [
    CourseSection(
      title: 'Chương 1: Giới thiệu',
      lectures: [
        Lecture(
          title: 'Bài 1: Chào mừng đến với khóa học',
          type: 'video',
          duration: '05:30',
        ),
        Lecture(
          title: 'Bài 2: Tổng quan nội dung',
          type: 'article',
          duration: '10:00',
        ),
      ],
    ),
    CourseSection(
      title: 'Chương 2: Kiến thức cơ bản',
      lectures: [
        Lecture(
          title: 'Bài 3: Khái niệm căn bản',
          type: 'video',
          duration: '15:20',
        ),
        Lecture(
          title: 'Bài 4: Kiểm tra kiến thức',
          type: 'quiz',
          duration: '20:00',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  IconData _getIconForLectureType(String type) {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'article':
        return Icons.article_outlined;
      case 'quiz':
        return Icons.quiz_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Color _getColorForLectureType(String type) {
    switch (type) {
      case 'video':
        return Colors.red;
      case 'article':
        return Colors.blue;
      case 'quiz':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              foregroundColor: Colors.white, // <--- THÊM DÒNG NÀY VÀO ĐÂY
              expandedHeight: 200,
              pinned: true,
              floating: false,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                // Giờ thì Text sẽ tự động có màu trắng
                title: Text(
                  widget.course.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize:
                        16, // Flutter sẽ tự động co giãn kích thước khi thu gọn
                  ),
                ),
                background: widget.course.imageFile != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            widget.course.imageFile!,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              theme.primaryColor,
                              theme.primaryColor.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.preview_outlined),
                  tooltip: 'Xem dưới dạng học viên',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Chức năng xem trước'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: theme.scaffoldBackgroundColor,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: theme.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: theme.primaryColor,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.dashboard_outlined),
                        text: 'Tổng quan',
                      ),
                      Tab(
                        icon: Icon(Icons.menu_book_outlined),
                        text: 'Nội dung',
                      ),
                      Tab(icon: Icon(Icons.people_outlined), text: 'Học viên'),
                      Tab(icon: Icon(Icons.settings_outlined), text: 'Cài đặt'),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(theme),
            _buildContentTab(theme),
            _buildStudentsTab(theme),
            _buildSettingsTab(theme),
          ],
        ),
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton.extended(
              onPressed: () {
                _showAddContentDialog(context);
              },
              label: const Text('Thêm nội dung'),
              icon: const Icon(Icons.add),
              elevation: 4,
            )
          : null,
    );
  }

  // === WIDGETS CHO CÁC TAB ===

  /// TAB 1: TỔNG QUAN
  Widget _buildOverviewTab(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCards(theme),
          const SizedBox(height: 24),
          _buildQuickActionsSection(theme),
          const SizedBox(height: 24),
          _buildRecentActivitySection(theme),
        ],
      ),
    );
  }

  Widget _buildStatCards(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thống kê',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard2(
                theme,
                'Học viên',
                '0',
                Icons.people_rounded,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard2(
                theme,
                'Bài giảng',
                '3',
                Icons.video_library_rounded,
                Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard2(
    ThemeData theme,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hành động nhanh',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          child: Column(
            children: [
              _buildActionTile(
                icon: Icons.announcement_rounded,
                title: 'Tạo thông báo mới',
                subtitle: 'Gửi thông báo đến học viên',
                color: Colors.blue,
                onTap: () {},
              ),
              const Divider(height: 1),
              _buildActionTile(
                icon: Icons.videocam_rounded,
                title: 'Bắt đầu buổi học Live',
                subtitle: 'Phát trực tiếp bài giảng',
                color: Colors.red,
                onTap: () {},
              ),
              const Divider(height: 1),
              _buildActionTile(
                icon: Icons.quiz_rounded,
                title: 'Tạo Quiz mới',
                subtitle: 'Kiểm tra kiến thức học viên',
                color: Colors.purple,
                onTap: () => _createQuiz(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: onTap,
    );
  }

  Widget _buildRecentActivitySection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hoạt động gần đây',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.history, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text(
                    'Chưa có hoạt động nào',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// TAB 2: NỘI DUNG KHÓA HỌC
  Widget _buildContentTab(ThemeData theme) {
    if (_courseContent.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book_outlined, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'Chưa có nội dung nào',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nhấn nút + để thêm chương hoặc bài giảng',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: _courseContent.length,
      itemBuilder: (context, index) {
        final section = _courseContent[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              childrenPadding: const EdgeInsets.only(bottom: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.folder_outlined, color: theme.primaryColor),
              ),
              title: Text(
                section.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                '${section.lectures.length} bài giảng',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
              children: section.lectures.map((lecture) {
                final color = _getColorForLectureType(lecture.type);
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getIconForLectureType(lecture.type),
                        color: color,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      lecture.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lecture.duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20),
                          onPressed: () {},
                        ),
                        const Icon(Icons.drag_handle, size: 20),
                      ],
                    ),
                    onTap: () {},
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  /// TAB 3: DANH SÁCH HỌC VIÊN
  Widget _buildStudentsTab(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Chưa có học viên nào',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// TAB 4: CÀI ĐẶT
  Widget _buildSettingsTab(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Thông tin khóa học',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.course.title,
                  decoration: InputDecoration(
                    labelText: 'Tên khóa học',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.title),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.course.description,
                  decoration: InputDecoration(
                    labelText: 'Mô tả',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Giá khóa học',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.attach_money),
                    suffixText: 'VNĐ',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã lưu thay đổi'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('Lưu thay đổi'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _createQuiz(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const QuizCreationScreen()));
  }

  void _showAddContentDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Thêm nội dung mới',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.folder, color: Colors.orange),
              title: const Text('Thêm chương mới'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.video_library, color: Colors.red),
              title: const Text('Thêm video'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.article, color: Colors.blue),
              title: const Text('Thêm bài viết'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.quiz, color: Colors.purple),
              title: const Text('Thêm quiz'),
              onTap: () {
                Navigator.pop(context);
                _createQuiz(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
