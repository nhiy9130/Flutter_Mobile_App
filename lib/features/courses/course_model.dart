class Course {
  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.code,
    required this.instructorName,
    this.thumbnailUrl,
    this.enrollmentCount = 0,
  });

  final String id;
  final String title;
  final String description;
  final String code;
  final String instructorName;
  final String? thumbnailUrl;
  final int enrollmentCount;
}
