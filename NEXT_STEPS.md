# 🎯 NEXT STEPS - Kế Hoạch Phát Triển Tiếp Theo

**Cập nhật:** October 2025  
**Trạng thái:** ✅ Ready to Execute

---

## 📋 Tóm Tắt Hiện Tại

### **Hoàn Thành ✅**
- ✅ 30+ UI Screens triển khai
- ✅ 3 Role-based interfaces (Student/Teacher/Admin)
- ✅ Real-time Chat (Socket.IO)
- ✅ WebRTC Livestream
- ✅ Quiz System (auto-grading)
- ✅ Push Notifications
- ✅ Local Storage (Hive)
- ✅ Multi-language support (VI/EN)

### **Completion Rate**
- **Core Screens:** 85% ✓
- **Overall Features:** 80% ✓
- **Test Coverage:** 65%

---

## 🚀 4-Week Sprint Plan

### **WEEK 1: File Management & Calendar (Days 1-7)**

#### **Priority 1: File Management Enhancement**
**Tệp:** `lib/screens/course_detail/files_tab.dart`

**Tasks:**
- [ ] Upgrade file listing UI
  - [ ] Add file type icons
  - [ ] Show file size & upload date
  - [ ] Sorting & filtering options
- [ ] Implement file operations
  - [ ] Download file with progress
  - [ ] Inline PDF viewer
  - [ ] Inline video player
  - [ ] Share file functionality
- [ ] Teacher upload features
  - [ ] Drag & drop upload
  - [ ] Bulk upload
  - [ ] File versioning
  - [ ] Expire dates
- [ ] Add tests
  - [ ] Unit tests for file service
  - [ ] Widget tests for UI

**Estimated Time:** 3-4 days  
**Files to Create/Modify:**
```
lib/screens/course_detail/files_tab.dart (modify)
lib/features/files/models/file_model.dart (create)
lib/features/files/services/file_service.dart (create)
lib/features/files/providers/file_provider.dart (create)
test/features/files_test.dart (create)
```

**Acceptance Criteria:**
- ✓ All file types can be downloaded
- ✓ PDF/Video preview inline
- ✓ Upload works for teachers
- ✓ Performance < 200ms

---

#### **Priority 2: Calendar Screen**
**Tệp:** `lib/screens/calendar_screen.dart` (NEW)

**Tasks:**
- [ ] Create calendar widget
  - [ ] Month/Week/Day views
  - [ ] Event indicators
  - [ ] Today highlight
- [ ] Add event types
  - [ ] Assignments (green)
  - [ ] Quizzes (blue)
  - [ ] Livestreams (red)
  - [ ] Deadlines (orange)
- [ ] Implement interactions
  - [ ] Tap day to see events
  - [ ] Set reminders (local notification)
  - [ ] Create events
- [ ] Add Google Calendar sync (optional Phase 2)

**Estimated Time:** 4-5 days  
**Files to Create:**
```
lib/screens/calendar_screen.dart (create)
lib/features/calendar/models/calendar_model.dart (create)
lib/features/calendar/services/calendar_service.dart (create)
lib/features/calendar/providers/calendar_provider.dart (create)
```

**Acceptance Criteria:**
- ✓ Calendar displays all events
- ✓ Reminders work properly
- ✓ Responsive on mobile
- ✓ Data syncs with backend

---

### **WEEK 2: Advanced Gradebook & Teacher Analytics (Days 8-14)**

#### **Priority 3: Enhanced Gradebook**
**Tệp:** `lib/screens/teacher/gradebook_screen.dart`

**Current Status:** Basic gradebook exists  
**Enhancements Needed:**

**Tasks:**
- [ ] Add grading features
  - [ ] Curve grading (curved grades)
  - [ ] Bulk grade entry
  - [ ] Grade formula/calculation
  - [ ] Extra credit
- [ ] Add feedback system
  - [ ] Inline comments
  - [ ] Comment templates
  - [ ] Rubric-based grading
  - [ ] Audio comments
- [ ] Add communication
  - [ ] Email individual grades
  - [ ] Email class summary
  - [ ] Grade posting options (hidden until date)
- [ ] Import/Export
  - [ ] Import from CSV
  - [ ] Export to Excel
  - [ ] Print gradebook

**Estimated Time:** 5-6 days

**Implementation Steps:**
```dart
// 1. Create GradebookProvider
final gradebookProvider = StateNotifierProvider((ref) => 
  GradebookNotifier(ref.read(apiProvider)));

// 2. Add curve grading logic
class CurveGrading {
  double curveGrades(List<double> scores, double target) {
    // Implementation
  }
}

// 3. Create comment templates
final commentTemplatesProvider = FutureProvider((ref) => 
  ref.read(teacherServiceProvider).getCommentTemplates());
```

---

#### **Priority 4: Teacher Analytics Dashboard**
**Tệp:** `lib/screens/teacher/analytics_screen.dart` (NEW)

**Features:**
- [ ] Class performance charts
  - [ ] Grade distribution (histogram)
  - [ ] Completion rate (pie chart)
  - [ ] Performance trends (line chart)
- [ ] Student insights
  - [ ] At-risk students alert
  - [ ] Active vs inactive
  - [ ] Engagement metrics
- [ ] Export reports
  - [ ] PDF report generation
  - [ ] Email reports

**Estimated Time:** 4-5 days

**Acceptance Criteria:**
- ✓ Charts render correctly
- ✓ Data updates in real-time
- ✓ Reports generate quickly
- ✓ Mobile-responsive

---

### **WEEK 3: Admin Analytics & Polish (Days 15-21)**

#### **Priority 5: Admin Analytics Dashboard**
**Tệp:** `lib/screens/admin/analytics_screen.dart` (NEW)

**Features:**
- [ ] System-wide statistics
  - [ ] User growth chart
  - [ ] Course enrollment trends
  - [ ] Platform usage metrics
- [ ] Health monitoring
  - [ ] Server uptime
  - [ ] Database performance
  - [ ] API response times
- [ ] User analytics
  - [ ] Active users by role
  - [ ] Login frequency
  - [ ] Session duration

**Estimated Time:** 4 days

---

#### **Priority 6: UI/UX Polish**
- [ ] Review all screens
- [ ] Fix responsive issues
- [ ] Standardize spacing & colors
- [ ] Improve animations
- [ ] Fix accessibility issues

**Estimated Time:** 3 days

---

### **WEEK 4: Testing & Optimization (Days 22-28)**

#### **Priority 7: Testing**
- [ ] Unit tests (70% coverage)
- [ ] Integration tests
- [ ] Performance testing
- [ ] Load testing

**Estimated Time:** 3-4 days

#### **Priority 8: Optimization**
- [ ] Bundle size reduction
- [ ] Image optimization
- [ ] API caching
- [ ] Database optimization

**Estimated Time:** 3-4 days

---

## 📊 Detailed Task Breakdown

### **File Management (3-4 days)**

```
Day 1:
  - Create file_model.dart
  - Create file_service.dart
  - Create file_provider.dart

Day 2:
  - Enhance files_tab.dart UI
  - Add download functionality
  - Add progress indicator

Day 3:
  - Implement PDF viewer
  - Implement video viewer
  - Add file sharing

Day 4 (optional):
  - Add upload feature
  - Add file versioning
  - Testing
```

**Code Example:**
```dart
// lib/features/files/services/file_service.dart
class FileService {
  Future<File> downloadFile(String fileId) async {
    final response = await _dio.get(
      '/api/files/$fileId/download',
      options: Options(responseType: ResponseType.bytes),
    );
    
    final file = File('${(await getApplicationDocumentsDirectory()).path}/$fileId');
    await file.writeAsBytes(response.data);
    return file;
  }
  
  Future<void> uploadFile(File file, String courseId) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
      "courseId": courseId,
    });
    
    await _dio.post('/api/files/upload', data: formData);
  }
}
```

---

### **Calendar Screen (4-5 days)**

```
Day 1:
  - Design calendar widget
  - Implement month view

Day 2:
  - Add event fetching
  - Display events on calendar

Day 3:
  - Implement day/week view
  - Add event details modal

Day 4:
  - Add reminders
  - Test on multiple devices

Day 5 (optional):
  - Add Google Calendar sync
  - Performance optimization
```

**Code Structure:**
```dart
// lib/screens/calendar_screen.dart
class CalendarScreen extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(calendarEventsProvider);
    
    return Scaffold(
      body: events.when(
        data: (eventList) => _buildCalendar(eventList),
        loading: () => ShimmerLoading(),
        error: (e, _) => ErrorWidget(error: e),
      ),
    );
  }
}
```

---

## ✅ Acceptance Criteria for Each Feature

### **File Management**
- [ ] Download button works for all file types
- [ ] PDF preview displays correctly
- [ ] Video plays inline with controls
- [ ] Upload progress shows for teachers
- [ ] File versioning works
- [ ] File sizes calculated correctly
- [ ] Sorting/filtering functional

### **Calendar**
- [ ] Month view displays all events
- [ ] Week view shows 7 days
- [ ] Day view shows hourly events
- [ ] Event colors match categories
- [ ] Reminders send at correct time
- [ ] Works offline (cached data)
- [ ] Mobile responsive

### **Advanced Gradebook**
- [ ] Curve grading calculates correctly
- [ ] Inline comments can be added
- [ ] Rubric grading works
- [ ] Excel export includes all data
- [ ] CSV import parses correctly
- [ ] Grade emails send
- [ ] Calculation formulas work

### **Analytics**
- [ ] Charts render smoothly
- [ ] Data updates in real-time
- [ ] Performance < 500ms for page load
- [ ] Mobile-responsive layout
- [ ] PDF export works
- [ ] Email reports send
- [ ] Data accuracy verified

---

## 🛠️ Development Setup

### **Required Tools**
```bash
# Flutter SDK
flutter --version  # Should be 3.9.2+

# Riverpod code generation
flutter pub add build_runner
flutter pub add riverpod_generator

# Testing
flutter pub add mocktail
flutter pub add integration_test

# Charts (for analytics)
flutter pub add fl_chart
```

### **Generate Riverpod Code**
```bash
flutter pub run build_runner build
```

---

## 📈 Progress Tracking

### **Metrics to Monitor**
- [ ] Screen load time < 500ms
- [ ] API response < 200ms
- [ ] Bundle size < 50MB
- [ ] 60+ FPS on animations
- [ ] Test coverage > 70%
- [ ] No console errors

### **Weekly Checklist**

**Week 1:**
- [ ] File Management 100%
- [ ] Calendar Screen 100%
- [ ] All tests passing
- [ ] No critical bugs

**Week 2:**
- [ ] Advanced Gradebook 100%
- [ ] Teacher Analytics 100%
- [ ] Performance optimized
- [ ] UI/UX polished

**Week 3:**
- [ ] Admin Analytics 100%
- [ ] Overall UI polish complete
- [ ] Responsive on all devices
- [ ] Accessibility improved

**Week 4:**
- [ ] Test coverage > 75%
- [ ] Performance tuned
- [ ] Ready for release
- [ ] Documentation updated

---

## 🐛 Known Issues to Address

| Issue | Priority | Status |
|-------|----------|--------|
| Calendar timezone handling | Medium | TODO |
| Gradebook scroll performance | Medium | TODO |
| File upload slow on 4G | High | TODO |
| Analytics chart redraw | Low | TODO |
| Admin dashboard load time | Medium | TODO |

---

## 💡 Tips for Success

1. **Start with File Management** - It's foundational for other features
2. **Test as you go** - Don't leave testing for the end
3. **Use performance profiler** - Check Lighthouse scores weekly
4. **Get user feedback** - Show progress to stakeholders
5. **Commit frequently** - Small commits are easier to debug

---

## 📞 Questions? Next Meeting Agenda

1. Confirm priorities with stakeholders
2. Discuss technical challenges
3. Plan testing strategy
4. Review performance targets
5. Schedule daily standups

---

**Ready to start? Let's build something amazing! 🚀**

Generated: October 2025
