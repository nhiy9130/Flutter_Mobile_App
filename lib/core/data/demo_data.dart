import '../../features/auth/auth_state.dart';
import '../../features/courses/course_model.dart';

/// Demo Accounts for Testing
class DemoAccounts {
  static const List<Map<String, dynamic>> accounts = [
    {
      'email': 'student@demo.com',
      'password': 'student123',
      'id': 1001,
      'fullName': 'Nguyễn Văn An',
      'role': 'student',
    },
    {
      'email': 'instructor@demo.com',
      'password': 'instructor123',
      'id': 2001,
      'fullName': 'TS. Trần Thị Bình',
      'role': 'instructor',
    },
    {
      'email': 'admin@demo.com',
      'password': 'admin123',
      'id': 3001,
      'fullName': 'Administrator',
      'role': 'admin',
    },
  ];

  static User? authenticate(String email, String password) {
    try {
      final account = accounts.firstWhere(
        (acc) => acc['email'] == email && acc['password'] == password,
      );
      return User(
        id: account['id'] as int,
        email: account['email'] as String,
        fullName: account['fullName'] as String,
        role: account['role'] as String,
      );
    } catch (e) {
      return null;
    }
  }

  static String getAccountInfo() {
    return '''
# Demo Accounts

## Student Account
- Email: student@demo.com
- Password: student123
- Full Name: Nguyễn Văn An

## Instructor Account
- Email: instructor@demo.com
- Password: instructor123
- Full Name: TS. Trần Thị Bình

## Admin Account
- Email: admin@demo.com
- Password: admin123
- Full Name: Administrator

---
Note: These are mock accounts for testing purposes only.
''';
  }
}

/// Demo Course Data
class DemoCourses {
  static List<Course> getStudentCourses() {
    return [
      const Course(
        id: 'course-1',
        code: 'FLT101',
        title: 'Introduction to Flutter Development',
        description: 'Learn Flutter from scratch and build beautiful cross-platform apps',
        instructorName: 'TS. Trần Thị Bình',
        thumbnailUrl: null,
        enrollmentCount: 245,
      ),
      const Course(
        id: 'course-2',
        code: 'RCT201',
        title: 'Advanced React & TypeScript',
        description: 'Master modern React patterns and TypeScript for production apps',
        instructorName: 'Dr. John Smith',
        thumbnailUrl: null,
        enrollmentCount: 189,
      ),
      const Course(
        id: 'course-3',
        code: 'DS101',
        title: 'Data Science with Python',
        description: 'Comprehensive guide to data analysis and machine learning',
        instructorName: 'Prof. Sarah Johnson',
        thumbnailUrl: null,
        enrollmentCount: 312,
      ),
      const Course(
        id: 'course-4',
        code: 'UXD101',
        title: 'UI/UX Design Fundamentals',
        description: 'Create stunning user interfaces and experiences',
        instructorName: 'Emily Davis',
        thumbnailUrl: null,
        enrollmentCount: 178,
      ),
      const Course(
        id: 'course-5',
        code: 'AWS201',
        title: 'Cloud Architecture with AWS',
        description: 'Build scalable cloud infrastructure on Amazon Web Services',
        instructorName: 'Michael Chen',
        thumbnailUrl: null,
        enrollmentCount: 156,
      ),
    ];
  }

  static List<Course> getInstructorCourses() {
    return [
      const Course(
        id: 'course-1',
        code: 'FLT101',
        title: 'Introduction to Flutter Development',
        description: 'Learn Flutter from scratch and build beautiful cross-platform apps',
        instructorName: 'TS. Trần Thị Bình',
        thumbnailUrl: null,
        enrollmentCount: 245,
      ),
      const Course(
        id: 'course-6',
        code: 'FLT301',
        title: 'Advanced Mobile Architecture',
        description: 'Master clean architecture and advanced patterns in mobile development',
        instructorName: 'TS. Trần Thị Bình',
        thumbnailUrl: null,
        enrollmentCount: 89,
      ),
    ];
  }

  static List<Course> getAllCourses() {
    final courses = <Course>[];
    courses.addAll(getStudentCourses());
    courses.addAll(getInstructorCourses());
    return courses;
  }
}

/// Demo Chat Messages
class DemoChatData {
  static List<Map<String, dynamic>> getMessages(String courseId) {
    return [
      {
        'id': 'msg-1',
        'courseId': courseId,
        'userId': 2001,
        'userName': 'TS. Trần Thị Bình',
        'message':
            'Chào mừng các bạn đến với khóa học! Hôm nay chúng ta sẽ bắt đầu với Flutter basics.',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'id': 'msg-2',
        'courseId': courseId,
        'userId': 1001,
        'userName': 'Nguyễn Văn An',
        'message': 'Cảm ơn thầy! Em rất hào hứng được học Flutter.',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      },
      {
        'id': 'msg-3',
        'courseId': courseId,
        'userId': 1002,
        'userName': 'Lê Thị Bình',
        'message': 'Thầy có thể giải thích về StatefulWidget và StatelessWidget không ạ?',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      },
      {
        'id': 'msg-4',
        'courseId': courseId,
        'userId': 2001,
        'userName': 'TS. Trần Thị Bình',
        'message':
            'StatelessWidget dùng cho UI không thay đổi, còn StatefulWidget có thể cập nhật state. Mình sẽ demo chi tiết trong bài học tiếp theo.',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
      },
    ];
  }
}

/// Demo Notifications
class DemoNotifications {
  static List<Map<String, dynamic>> getNotifications(int userId) {
    return [
      {
        'id': 'notif-1',
        'userId': userId,
        'title': 'Bài tập mới',
        'body': 'Bạn có bài tập mới trong khóa học Flutter Development',
        'type': 'assignment',
        'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
        'isRead': false,
      },
      {
        'id': 'notif-2',
        'userId': userId,
        'title': 'Quiz sắp bắt đầu',
        'body': 'Quiz về React Fundamentals sẽ mở trong 30 phút nữa',
        'type': 'quiz',
        'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
        'isRead': false,
      },
      {
        'id': 'notif-3',
        'userId': userId,
        'title': 'Livestream thông báo',
        'body': 'Buổi livestream sẽ bắt đầu lúc 19:00 hôm nay',
        'type': 'livestream',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)),
        'isRead': true,
      },
      {
        'id': 'notif-4',
        'userId': userId,
        'title': 'Điểm mới',
        'body': 'Bạn đã nhận được 95/100 điểm cho bài kiểm tra Python',
        'type': 'grade',
        'timestamp': DateTime.now().subtract(const Duration(days: 2)),
        'isRead': true,
      },
    ];
  }
}

/// Demo Quiz Questions
class DemoQuizData {
  static Map<String, List<Map<String, dynamic>>> getQuizzes() {
    return {
      'course-1': [
        {
          'id': 'q1',
          'question': 'Flutter được phát triển bởi công ty nào?',
          'type': 'multiple',
          'options': ['Google', 'Facebook', 'Apple', 'Microsoft'],
          'correctAnswer': 'Google',
          'points': 1,
        },
        {
          'id': 'q2',
          'question': 'Dart là ngôn ngữ strongly typed?',
          'type': 'truefalse',
          'options': ['Đúng', 'Sai'],
          'correctAnswer': 'Đúng',
          'points': 1,
        },
        {
          'id': 'q3',
          'question': 'Lệnh nào để tạo Flutter project mới?',
          'type': 'short',
          'correctAnswer': 'flutter create',
          'points': 2,
        },
        {
          'id': 'q4',
          'question': 'Giải thích sự khác biệt giữa hot reload và hot restart trong Flutter',
          'type': 'essay',
          'points': 5,
        },
      ],
      'course-2': [
        {
          'id': 'q1',
          'question': 'React Hooks được giới thiệu trong phiên bản nào?',
          'type': 'multiple',
          'options': ['16.7', '16.8', '17.0', '18.0'],
          'correctAnswer': '16.8',
          'points': 1,
        },
        {
          'id': 'q2',
          'question': 'TypeScript là một superset của JavaScript?',
          'type': 'truefalse',
          'options': ['True', 'False'],
          'correctAnswer': 'True',
          'points': 1,
        },
      ],
    };
  }
}
