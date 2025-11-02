import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'lecture_content_screen.dart';

// Lớp dữ liệu mô hình (thường sẽ nằm trong folder models)
class Lesson {
  final String id;
  final String title;
  final String type; // 'video', 'document', 'quiz'
  bool isCompleted;

  Lesson({
    required this.id,
    required this.title,
    required this.type,
    required this.isCompleted,
  });
}

class Chapter {
  final String title;
  final List<Lesson> lessons;

  Chapter(this.title, this.lessons);
}

class StudentContentTab extends StatelessWidget {
  const StudentContentTab({super.key});

  // Dữ liệu giả để minh họa
  static final List<Chapter> _dummyChapters = [
    Chapter('Chương 1: Giới thiệu về Flutter', [
      Lesson(
        id: '1',
        title: 'Bài 1: Flutter là gì và tại sao nên học?',
        type: 'video',
        isCompleted: true,
      ),
      Lesson(
        id: '2',
        title: 'Bài 2: Hướng dẫn cài đặt môi trường',
        type: 'document',
        isCompleted: true,
      ),
      Lesson(
        id: '3',
        title: 'Bài 3: Xây dựng ứng dụng "Hello World"',
        type: 'video',
        isCompleted: false,
      ),
    ]),
    Chapter('Chương 2: Widgets cơ bản', [
      Lesson(
        id: '4',
        title: 'Bài 4: StatelessWidget vs StatefulWidget',
        type: 'video',
        isCompleted: false,
      ),
      Lesson(
        id: '5',
        title: 'Bài 5: Tìm hiểu về Text, Row, Column',
        type: 'video',
        isCompleted: false,
      ),
      Lesson(
        id: '6',
        title: 'Bài 6: Các loại Widget phổ biến',
        type: 'document',
        isCompleted: false,
      ),
      Lesson(
        id: '7',
        title: 'Bài kiểm tra chương 2',
        type: 'quiz',
        isCompleted: false,
      ),
    ]),
    Chapter('Chương 3: Navigation và Routing', [
      Lesson(
        id: '8',
        title: 'Bài 7: Sử dụng Navigator 1.0',
        type: 'video',
        isCompleted: false,
      ),
      Lesson(
        id: '9',
        title: 'Bài 8: Giới thiệu GoRouter',
        type: 'video',
        isCompleted: false,
      ),
    ]),
  ];

  Icon _getLessonIcon(String type) {
    switch (type) {
      case 'video':
        return const Icon(Icons.play_circle_outline, color: AppColors.primary);
      case 'document':
        return const Icon(Icons.article_outlined, color: AppColors.accent);
      case 'quiz':
        return const Icon(Icons.quiz_outlined, color: AppColors.warning);
      default:
        return const Icon(Icons.help_outline, color: AppColors.grey500);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _dummyChapters.length,
      itemBuilder: (context, index) {
        final chapter = _dummyChapters[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            title: Text(
              chapter.title,
              style: AppTypography.h6.copyWith(color: AppColors.grey800),
            ),
            childrenPadding: const EdgeInsets.only(bottom: 8),
            children: chapter.lessons.map((lesson) {
              return ListTile(
                leading: _getLessonIcon(lesson.type),
                title: Text(
                  lesson.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: lesson.isCompleted
                        ? AppColors.grey500
                        : AppColors.grey700,
                  ),
                ),
                trailing: lesson.isCompleted
                    ? const Icon(Icons.check_circle, color: AppColors.success)
                    : null,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          LectureContentScreen(lesson: lesson),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
