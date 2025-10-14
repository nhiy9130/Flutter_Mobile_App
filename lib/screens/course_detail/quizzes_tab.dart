import 'dart:async';

import 'package:flutter/material.dart';
import '../../features/quiz/quiz_service.dart';

class QuizzesTabView extends StatefulWidget {
  const QuizzesTabView({super.key, required this.courseId});
  final String courseId;

  @override
  State<QuizzesTabView> createState() => _QuizzesTabViewState();
}

class _QuizzesTabViewState extends State<QuizzesTabView> {
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = quizService.session;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (session == null || !session.isActive) ...[
            ElevatedButton(
              onPressed: () {
                quizService.start(widget.courseId, 1001); // Mock user ID
                _startTimer();
                setState(() {});
              },
              child: const Text('Start Live Quiz (Demo)'),
            ),
          ] else ...[
            Text('Question ${session.currentIndex + 1}/${session.questions.length}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(session.questions[session.currentIndex].question),
            const SizedBox(height: 8),
            Text('⏱ ${session.timeRemaining}s'),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (quizService.next()) {
                      setState(() {});
                    } else {
                      setState(() {});
                    }
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    quizService.end();
                    setState(() {});
                  },
                  child: const Text('End'),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final s = quizService.session;
      if (s == null || !s.isActive) {
        t.cancel();
        return;
      }
      if (s.timeRemaining > 0) {
        s.timeRemaining -= 1;
        setState(() {});
      } else {
        if (!quizService.next()) {
          setState(() {});
        }
      }
    });
  }
}



