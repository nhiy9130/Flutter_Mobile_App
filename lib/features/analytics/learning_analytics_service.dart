class LearningAnalyticsData {
  const LearningAnalyticsData({
    required this.totalTimeSpentMin,
    required this.activitiesCount,
    required this.averagePerformance,
    required this.learningStreakDays,
    required this.engagement,
  });

  final int totalTimeSpentMin;
  final int activitiesCount;
  final double averagePerformance; // 0..100
  final int learningStreakDays;
  final Map<String, int> engagement; // chat, quiz, livestream, material
}

class LearningAnalyticsService {
  Future<LearningAnalyticsData> getAnalytics(int userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const LearningAnalyticsData(
      totalTimeSpentMin: 245,
      activitiesCount: 42,
      averagePerformance: 82.5,
      learningStreakDays: 6,
      engagement: {
        'chatParticipation': 8,
        'quizCompletion': 5,
        'livestreamAttendance': 3,
        'materialAccess': 12,
      },
    );
  }
}

final learningAnalyticsService = LearningAnalyticsService();
