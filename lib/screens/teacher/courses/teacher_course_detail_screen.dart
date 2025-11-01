import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:uuid/uuid.dart';
// ignore: unused_import
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import '../../../features/courses/courses_service.dart';
import '../../../features/courses/course_model.dart';
// import '../quiz/quiz_creation_screen.dart';
import 'tabs/content_tab.dart';
import '../../../core/widgets/custom_cards.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/custom_button.dart';

// Models
class Lecture {
  final String id;
  String title;
  String type; // 'video', 'file', 'text' | backward: 'article','quiz'
  String? url; // for video link
  String? filePath; // for uploaded file
  String? textJson; // for quill document
  String? duration; // optional legacy

  Lecture({
    required this.id,
    required this.title,
    required this.type,
    this.url,
    this.filePath,
    this.textJson,
    this.duration,
  });
}

class CourseSection {
  final String id;
  String title;
  final List<Lecture> lectures;
  CourseSection({
    required this.id,
    required this.title,
    required this.lectures,
  });
}

class AssignmentItem {
  String title;
  DateTime deadline;
  int submitted;
  int total;
  AssignmentItem({
    required this.title,
    required this.deadline,
    required this.submitted,
    required this.total,
  });
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
  final _uuid = const Uuid();

  final List<CourseSection> _courseContent = [];
  final List<AssignmentItem> _assignments = [];
  final List<Map<String, String>> _announcements = [];
  final List<Map<String, String>> _students = [];
  String _studentQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // seed demo data (optional)
    _assignments.addAll([
      AssignmentItem(
        title: 'Bài tập 1: Widgets cơ bản',
        deadline: DateTime.now().add(const Duration(days: 3)),
        submitted: 12,
        total: 40,
      ),
      AssignmentItem(
        title: 'Quiz: State Management',
        deadline: DateTime.now().add(const Duration(days: 7)),
        submitted: 5,
        total: 40,
      ),
    ]);
    _announcements.addAll([
      {
        'title': 'Chào mừng đến với khóa học!',
        'message': 'Hãy đọc kỹ syllabus và hoàn thành khảo sát tuần 1.',
        'time': 'Hôm nay 09:00',
      },
      {
        'title': 'Cập nhật tài liệu buổi 2',
        'message': 'Đã upload slide và bài đọc tham khảo.',
        'time': 'Hôm qua 16:20',
      },
    ]);
    _students.addAll([
      {
        'id': 'SV001',
        'name': 'Nguyễn Văn A',
        'email': 'a.nguyen@example.com',
        'joined': '2025-10-01',
      },
      {
        'id': 'SV002',
        'name': 'Trần Thị B',
        'email': 'b.tran@example.com',
        'joined': '2025-10-02',
      },
      {
        'id': 'SV003',
        'name': 'Lê Hoàng C',
        'email': 'c.le@example.com',
        'joined': '2025-10-03',
      },
    ]);
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
      case 'file':
        return Colors.teal;
      case 'text':
        return Colors.purple;
      case 'article':
        return Colors.blue;
      case 'quiz':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  // Thêm chương mới
  void _addNewSection(String sectionTitle) {
    if (sectionTitle.trim().isEmpty) return;
    setState(() {
      _courseContent.add(
        CourseSection(id: _uuid.v4(), title: sectionTitle, lectures: []),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Đã thêm chương: $sectionTitle')),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ============== CÁC HÀM QUẢN LÝ CHƯƠNG HỌC ==============

  void _showEditSectionDialog(BuildContext context, int sectionIndex) {
    final TextEditingController controller = TextEditingController(
      text: _courseContent[sectionIndex].title,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Chỉnh sửa tên chương',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Tên chương',
            hintText: 'Ví dụ: Chương 1: Kiến thức cơ bản',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.folder_outlined),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              Navigator.pop(context);
              _editSectionTitle(sectionIndex, value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context);
                _editSectionTitle(sectionIndex, controller.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _editSectionTitle(int index, String newTitle) {
    setState(() {
      _courseContent[index].title = newTitle;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Đã cập nhật tên chương: $newTitle')),
          ],
        ),
        backgroundColor: Colors.blue.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showDeleteSectionConfirmationDialog(
    BuildContext context,
    int sectionIndex,
  ) {
    final sectionTitle = _courseContent[sectionIndex].title;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Xóa chương',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Bạn có chắc chắn muốn xóa chương "$sectionTitle" không? Thao tác này sẽ xóa tất cả bài giảng bên trong.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteSection(sectionIndex, sectionTitle);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _deleteSection(int index, String title) {
    setState(() {
      _courseContent.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.delete_forever_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('Đã xóa chương: $title')),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ========================================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              foregroundColor: Colors.white,
              expandedHeight: 300,
              title: Text(
                widget.course.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              pinned: true,
              floating: false,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
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
                                  Colors.black.withAlpha(179),
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
                              theme.primaryColor.withAlpha(179),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: theme.primaryColor,
                  unselectedLabelColor: Colors.grey[700],
                  indicatorColor: theme.primaryColor,
                  tabs: const [
                    Tab(text: 'Nội dung'),
                    Tab(text: 'Sinh viên'),
                    Tab(text: 'Bài tập & Điểm số'),
                    Tab(text: 'Thông báo'),
                    Tab(text: 'Cài đặt'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // TAB 1: NỘI DUNG KHÓA HỌC (mới)
            ContentTab(
              courseContent: _courseContent,
              onAddSection: (ctx) => _showAddSectionDialog(ctx),
              onEditSection: (ctx, i) => _showEditSectionDialog(ctx, i),
              onDeleteSection: (ctx, i) =>
                  _showDeleteSectionConfirmationDialog(ctx, i),
              onAddEditLecture: (ctx, sectionIndex, {lecture, lectureIndex}) =>
                  _showAddEditLectureDialog(
                    ctx,
                    sectionIndex,
                    lecture: lecture,
                    lectureIndex: lectureIndex,
                  ),
              onDeleteLecture: (ctx, sectionIndex, lectureIndex, title) =>
                  _confirmDeleteLecture(ctx, sectionIndex, lectureIndex, title),
              onReorderSections: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = _courseContent.removeAt(oldIndex);
                  _courseContent.insert(newIndex, item);
                });
              },
              onReorderLectures: (sectionIndex, oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = _courseContent[sectionIndex].lectures.removeAt(
                    oldIndex,
                  );
                  _courseContent[sectionIndex].lectures.insert(newIndex, item);
                });
              },
              getIconForType: _getIconForLectureType,
              getColorForType: _getColorForLectureType,
            ),
            _buildStudentsTab(theme),
            _buildAssignmentsTab(theme),
            _buildAnnouncementsTab(theme),
            _buildSettingsTab(theme),
          ],
        ),
      ),
    );
  }

  /// TAB 2: SINH VIÊN
  Widget _buildStudentsTab(ThemeData theme) {
    final filtered = _students
        .where(
          (s) =>
              _studentQuery.isEmpty ||
              s['name']!.toLowerCase().contains(_studentQuery.toLowerCase()) ||
              s['email']!.toLowerCase().contains(_studentQuery.toLowerCase()) ||
              s['id']!.toLowerCase().contains(_studentQuery.toLowerCase()),
        )
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 240),
              child: SizedBox(
                width: 420,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm sinh viên... (MSSV, tên, email)',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    isDense: true,
                  ),
                  onChanged: (v) => setState(() => _studentQuery = v),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => _showInviteStudentDialog(context),
              icon: const Icon(Icons.mail_outline),
              label: const Text('Mời sinh viên'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (filtered.isEmpty)
          const CustomCard(
            child: EmptyState(
              icon: Icons.person_search_rounded,
              title: 'Không tìm thấy sinh viên',
              subtitle: 'Hãy thử từ khóa khác hoặc mời sinh viên tham gia lớp',
            ),
          )
        else
          ...filtered.map((s) {
            final isJoined = (s['joined'] != null && s['joined']!.isNotEmpty);
            final name = s['name']!;
            final email = s['email']!;
            final id = s['id']!;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CustomCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20, // 40px đường kính
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : '?',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$email • $id',
                            style: TextStyle(color: Colors.grey[700]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Chip(
                      label: Text(isJoined ? 'Đã tham gia' : 'Chờ duyệt'),
                      backgroundColor: (isJoined ? Colors.green : Colors.orange)
                          .withValues(alpha: 0.1),
                      side: BorderSide(
                        color: (isJoined ? Colors.green : Colors.orange)
                            .withValues(alpha: 0.3),
                      ),
                      labelStyle: TextStyle(
                        color: isJoined ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      tooltip: 'Tùy chọn',
                      onSelected: (value) async {
                        if (value == 'approve') {
                          if (!isJoined) {
                            setState(() {
                              s['joined'] = DateTime.now().toIso8601String();
                            });
                          }
                        } else if (value == 'remove') {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Xóa khỏi lớp?'),
                              content: Text(
                                'Bạn có chắc muốn xóa $name khỏi lớp?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Hủy'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text('Xóa'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            setState(() {
                              _students.removeWhere((e) => e['id'] == id);
                            });
                          }
                        }
                      },
                      itemBuilder: (context) => [
                        if (!isJoined)
                          const PopupMenuItem(
                            value: 'approve',
                            child: Text('Duyệt tham gia'),
                          ),
                        const PopupMenuItem(
                          value: 'remove',
                          child: Text('Xóa khỏi lớp'),
                        ),
                      ],
                      icon: const Icon(Icons.more_vert_rounded),
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  /// TAB 3: BÀI TẬP & ĐIỂM SỐ
  Widget _buildAssignmentsTab(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final bool isNarrow = constraints.maxWidth < 700;
            if (isNarrow) {
              // Trên màn hình hẹp, xếp dọc để tránh tràn
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    onPressed: _openCreateAssignment,
                    text: 'Tạo bài tập mới',
                    icon: Icons.add_task_rounded,
                    variant: ButtonVariant.primary,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    onPressed: _openGradebook,
                    text: 'Xem Bảng điểm tổng hợp',
                    icon: Icons.grid_on_rounded,
                    variant: ButtonVariant.outline,
                  ),
                ],
              );
            }
            // Màn hình đủ rộng: đặt 2 nút trên cùng một hàng
            return Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: _openCreateAssignment,
                    text: 'Tạo bài tập mới',
                    icon: Icons.add_task_rounded,
                    variant: ButtonVariant.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    onPressed: _openGradebook,
                    text: 'Xem Bảng điểm tổng hợp',
                    icon: Icons.grid_on_rounded,
                    variant: ButtonVariant.outline,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        if (_assignments.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
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
            child: const Center(child: Text('Chưa có bài tập nào')),
          )
        else
          ..._assignments.map((a) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.assignment_outlined),
                title: Text(
                  a.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Hạn nộp: ${_fmtDateTime(a.deadline)} • Đã nộp: ${a.submitted}/${a.total}',
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => _openGrading(a),
              ),
            );
          }),
      ],
    );
  }

  /// TAB 4: THÔNG BÁO
  Widget _buildAnnouncementsTab(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton.icon(
            onPressed: _openCreateAnnouncement,
            icon: const Icon(Icons.campaign_outlined),
            label: const Text('Tạo thông báo'),
          ),
        ),
        const SizedBox(height: 12),
        ..._announcements.map(
          (n) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.announcement_outlined),
              title: Text(n['title']!),
              subtitle: Text(n['message']!),
              trailing: Text(
                n['time']!,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helpers for Assignments/Announcements/Students
  String _fmtDateTime(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}'
        .toString();
  }

  void _openCreateAssignment() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final titleCtl = TextEditingController();
        final descCtl = TextEditingController();
        final pointsCtl = TextEditingController(text: '10');
        DateTime? pickedDeadline;
        String deadlineLabel = 'Chọn hạn nộp';
        return StatefulBuilder(
          builder: (context, setModalState) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tạo bài tập mới',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleCtl,
                  decoration: InputDecoration(
                    labelText: 'Tiêu đề bài tập',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.title_rounded),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descCtl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Mô tả / Yêu cầu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.description_outlined),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: pointsCtl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tổng điểm',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.score_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final d = await showDatePicker(
                            context: ctx,
                            initialDate: DateTime.now().add(
                              const Duration(days: 3),
                            ),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (d != null) {
                            setModalState(() {
                              pickedDeadline = d;
                              deadlineLabel = _fmtDateTime(d);
                            });
                          }
                        },
                        icon: const Icon(Icons.event_outlined),
                        label: Text(deadlineLabel),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Hủy'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (titleCtl.text.trim().isEmpty) return;
                        setState(() {
                          _assignments.add(
                            AssignmentItem(
                              title: titleCtl.text.trim(),
                              deadline:
                                  pickedDeadline ??
                                  DateTime.now().add(const Duration(days: 7)),
                              submitted: 0,
                              total: _students.length,
                            ),
                          );
                        });
                        Navigator.pop(ctx);
                      },
                      child: const Text('Giao bài'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openGrading(AssignmentItem a) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _GradingScreen(assignment: a, students: _students),
      ),
    );
  }

  void _openGradebook() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            _GradebookScreen(students: _students, assignments: _assignments),
      ),
    );
  }

  void _openCreateAnnouncement() {
    final titleCtl = TextEditingController();
    final msgCtl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tạo thông báo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtl,
              decoration: const InputDecoration(labelText: 'Tiêu đề'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: msgCtl,
              decoration: const InputDecoration(labelText: 'Nội dung'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _announcements.insert(0, {
                  'title': titleCtl.text.trim(),
                  'message': msgCtl.text.trim(),
                  'time': 'Vừa xong',
                });
              });
              Navigator.pop(ctx);
            },
            child: const Text('Đăng'),
          ),
        ],
      ),
    );
  }

  void _showInviteStudentDialog(BuildContext context) {
    final emailCtl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Mời sinh viên'),
        content: TextField(
          controller: emailCtl,
          decoration: const InputDecoration(
            labelText: 'Email sinh viên',
            hintText: 'student@example.com',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Đã gửi lời mời')));
            },
            child: const Text('Gửi mời'),
          ),
        ],
      ),
    );
  }

  void _showAddEditLectureDialog(
    BuildContext context,
    int sectionIndex, {
    Lecture? lecture,
    int? lectureIndex,
  }) {
    final isEdit = lecture != null;
    final titleCtl = TextEditingController(text: lecture?.title ?? '');
    String type = lecture?.type ?? 'video';
    final linkCtl = TextEditingController(text: lecture?.url ?? '');
    String? pickedFilePath = lecture?.filePath;
    String pickedFileName = pickedFilePath != null && pickedFilePath.isNotEmpty
        ? pickedFilePath.split('\\').last.split('/').last
        : '';
    final quillController = quill.QuillController.basic();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(isEdit ? 'Chỉnh sửa bài giảng' : 'Thêm bài giảng'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleCtl,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề bài giảng',
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: type,
                  items: const [
                    DropdownMenuItem(value: 'video', child: Text('Video')),
                    DropdownMenuItem(value: 'file', child: Text('Tệp tin')),
                    DropdownMenuItem(value: 'text', child: Text('Văn bản')),
                  ],
                  onChanged: (v) => setLocal(() => type = v ?? 'video'),
                  decoration: const InputDecoration(labelText: 'Loại nội dung'),
                ),
                const SizedBox(height: 12),
                if (type == 'video') ...[
                  TextField(
                    controller: linkCtl,
                    decoration: const InputDecoration(
                      labelText: 'Link Youtube/Vimeo',
                      hintText: 'https://...',
                    ),
                  ),
                ] else if (type == 'file') ...[
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final res = await FilePicker.platform.pickFiles();
                          if (res != null && res.files.isNotEmpty) {
                            setLocal(() {
                              pickedFilePath = res.files.single.path;
                              pickedFileName = res.files.single.name;
                            });
                          }
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Tải lên'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          pickedFileName.isNotEmpty
                              ? pickedFileName
                              : 'Chưa chọn tệp',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ] else if (type == 'text') ...[
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: quill.QuillEditor.basic(controller: quillController),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleCtl.text.trim().isEmpty) return;
                setState(() {
                  if (isEdit) {
                    final l =
                        _courseContent[sectionIndex].lectures[lectureIndex!];
                    l.title = titleCtl.text.trim();
                    l.type = type;
                    l.url = type == 'video' ? linkCtl.text.trim() : null;
                    l.filePath = type == 'file' ? pickedFilePath : null;
                    if (type == 'text') {
                      try {
                        l.textJson = jsonEncode(
                          quillController.document.toDelta().toJson(),
                        );
                      } catch (_) {
                        l.textJson = '';
                      }
                    } else {
                      l.textJson = null;
                    }
                  } else {
                    _courseContent[sectionIndex].lectures.add(
                      Lecture(
                        id: _uuid.v4(),
                        title: titleCtl.text.trim(),
                        type: type,
                        url: type == 'video' ? linkCtl.text.trim() : null,
                        filePath: type == 'file' ? pickedFilePath : null,
                        textJson: type == 'text'
                            ? jsonEncode(
                                quillController.document.toDelta().toJson(),
                              )
                            : null,
                      ),
                    );
                  }
                });
                Navigator.pop(ctx);
              },
              child: Text(isEdit ? 'Lưu' : 'Thêm'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteLecture(
    BuildContext context,
    int sectionIndex,
    int lectureIndex,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa bài giảng'),
        content: Text('Bạn có chắc chắn muốn xóa "$title" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _courseContent[sectionIndex].lectures.removeAt(lectureIndex);
              });
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('Xóa'),
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
        const Text(
          'Thông tin khóa học',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.course.title,
                decoration: InputDecoration(
                  labelText: 'Tên khóa học',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.title_rounded),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.course.description,
                decoration: InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description_rounded),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Giá khóa học',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.attach_money_rounded),
                  suffixText: 'VNĐ',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle_rounded, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Đã lưu thay đổi'),
                    ],
                  ),
                  backgroundColor: Colors.green.shade600,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            icon: const Icon(Icons.save_rounded),
            label: const Text(
              'Lưu thay đổi',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddSectionDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Thêm chương mới',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Tên chương',
            hintText: 'Ví dụ: Chương 1: Giới thiệu',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.folder_outlined),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              Navigator.pop(context);
              _addNewSection(value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context);
                _addNewSection(controller.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }
}

class _GradingScreen extends StatelessWidget {
  final AssignmentItem assignment;
  final List<Map<String, String>> students;
  const _GradingScreen({required this.assignment, required this.students});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chấm: ${assignment.title}')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: const [
                Chip(label: Text('Tất cả')),
                Chip(label: Text('Đã nộp')),
                Chip(label: Text('Chưa nộp')),
                Chip(label: Text('Đã chấm')),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: students.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final s = students[i];
                return ListTile(
                  leading: CircleAvatar(child: Text(s['name']![0])),
                  title: Text(s['name']!),
                  subtitle: Text(s['email']!),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Chấm điểm'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GradebookScreen extends StatelessWidget {
  final List<Map<String, String>> students;
  final List<AssignmentItem> assignments;
  const _GradebookScreen({required this.students, required this.assignments});

  @override
  Widget build(BuildContext context) {
    final shownAssignments = assignments.take(3).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Bảng điểm tổng hợp')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            columns: [
              const DataColumn(label: Text('Sinh viên')),
              ...shownAssignments
                  .map((a) => DataColumn(label: Text(a.title)))
                  .toList(),
              const DataColumn(label: Text('Tổng kết')),
            ],
            rows: students.map((s) {
              final scores = List<int>.generate(
                shownAssignments.length,
                (i) => 0,
              );
              final total = scores.fold<int>(0, (sum, e) => sum + e);
              return DataRow(
                cells: [
                  DataCell(Text(s['name']!)),
                  ...scores.map((sc) => DataCell(Text('$sc'))),
                  DataCell(Text('$total')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _TabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}
