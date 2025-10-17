# 🚀 QUICK REFERENCE GUIDE - Bắt Đầu Nhanh

**Dành cho:** Team Developers  
**Mục đích:** Quick start guide cho phase tiếp theo

---

## 📍 Vị Trí Tệp Quan Trọng

### **Documentation**
```
📁 Project Root
├── Screens.md ⭐⭐⭐ (Thiết kế chi tiết 30+ screens)
├── NEXT_STEPS.md ⭐⭐⭐ (4-week roadmap)
├── DESIGN_ANALYSIS_SUMMARY.md ⭐⭐⭐ (Executive summary)
├── COMPLETION_REPORT.md (What was done)
├── DEMO_GUIDE.md (Feature walkthrough)
├── IMPLEMENTATION_SUMMARY.md (Technical details)
└── BUILD_INSTRUCTIONS.md (Build & deploy)
```

### **Source Code Structure**
```
lib/
├── main.dart
├── app.dart
├── screens/ (30+ screens)
│   ├── auth/
│   ├── dashboard/
│   ├── courses/
│   ├── course_detail/
│   ├── teacher/
│   ├── admin/
│   ├── livestream/
│   └── viewers/
├── features/ (Business logic)
│   ├── auth/
│   ├── courses/
│   ├── chat/
│   ├── quiz/
│   ├── livestream/
│   ├── notifications/
│   └── ...
├── core/ (Services)
│   ├── config/
│   ├── network/
│   ├── realtime/
│   ├── storage/
│   ├── webrtc/
│   └── widgets/
└── routes/
```

---

## 🎯 Priority Tasks (Next 4 Weeks)

### **MUST DO (High Priority)**

#### **1. File Management** (Days 1-3)
- **Files:** `lib/screens/course_detail/files_tab.dart`
- **Tasks:**
  - [ ] Enhance file listing UI
  - [ ] Add download functionality
  - [ ] Add PDF/Video preview
  - [ ] Add upload for teachers
- **Status:** ⏳ Not started
- **Effort:** 3 days

#### **2. Calendar Screen** (Days 4-8)
- **Files:** `lib/screens/calendar_screen.dart` (NEW)
- **Tasks:**
  - [ ] Create calendar widget
  - [ ] Fetch events from API
  - [ ] Add event types & colors
  - [ ] Implement reminders
- **Status:** ⏳ Not started
- **Effort:** 5 days

#### **3. Advanced Gradebook** (Days 9-14)
- **Files:** `lib/screens/teacher/gradebook_screen.dart`
- **Tasks:**
  - [ ] Add curve grading
  - [ ] Add inline comments
  - [ ] Add export to Excel
  - [ ] Add email grades
- **Status:** ⏳ Not started
- **Effort:** 6 days

#### **4. Analytics Dashboard** (Days 15-19)
- **Files:** `lib/screens/teacher/analytics_screen.dart` (NEW)
- **Tasks:**
  - [ ] Create grade distribution chart
  - [ ] Create completion rate chart
  - [ ] Create performance trends
  - [ ] Implement export
- **Status:** ⏳ Not started
- **Effort:** 5 days

### **SHOULD DO (Medium Priority)**

#### **5. Testing** (Days 20-23)
- Increase test coverage to 75%
- Unit tests for all features
- Integration tests

#### **6. Performance** (Days 24-28)
- Optimize large list rendering
- Image optimization
- API caching

---

## 📋 Daily Standup Template

```
🌅 STANDUP MEETING

Participant: [Your Name]
Date: [Date]
Sprint: [Week N]

✅ YESTERDAY (What I completed)
- [ ] Task 1
- [ ] Task 2

🔄 TODAY (What I'm working on)
- [ ] Task 3
- [ ] Task 4

⚠️ BLOCKERS (Any issues)
- Issue 1
- Issue 2

📊 Progress: [X]% of sprint done
```

---

## 🛠️ Development Workflow

### **Setup (First Time)**

```bash
# 1. Clone repo
git clone <repo-url>
cd lms_mobile_flutter

# 2. Install dependencies
flutter pub get
flutter pub run build_runner build

# 3. Run app
flutter run

# 4. Check current state
flutter analyze
```

### **Start New Feature**

```bash
# 1. Create branch
git checkout -b feature/calendar-screen

# 2. Create files
lib/screens/calendar_screen.dart
lib/features/calendar/models/calendar_model.dart
lib/features/calendar/providers/calendar_provider.dart
lib/features/calendar/services/calendar_service.dart

# 3. Implement feature
# (Follow code templates in NEXT_STEPS.md)

# 4. Test
flutter test

# 5. Commit
git add .
git commit -m "feat: add calendar screen"
git push origin feature/calendar-screen

# 6. Create PR & get review
```

---

## 📚 Code Templates

### **Create New Screen**

```dart
// lib/screens/new_feature_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewFeatureScreen extends ConsumerStatefulWidget {
  const NewFeatureScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NewFeatureScreen> createState() => _NewFeatureScreenState();
}

class _NewFeatureScreenState extends ConsumerState<NewFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(newFeatureProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('New Feature')),
      body: data.when(
        data: (items) => _buildBody(items),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildBody(List<dynamic> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item ${items[index]}'),
        );
      },
    );
  }
}
```

### **Create Provider**

```dart
// lib/features/new_feature/providers/new_feature_provider.dart
import 'package:riverpod/riverpod.dart';

final newFeatureProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(newFeatureServiceProvider);
  return await service.fetchData();
});

final newFeatureServiceProvider = Provider((ref) {
  return NewFeatureService(ref.read(apiProvider));
});
```

### **Create Test**

```dart
// test/features/new_feature_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('NewFeature', () {
    test('fetches data correctly', () async {
      // Arrange
      
      // Act
      
      // Assert
    });
  });
}
```

---

## 🐛 Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| **Build fails** | Run `flutter clean && flutter pub get` |
| **Hot reload not working** | Restart Flutter: `flutter run` |
| **Provider not updating** | Check `ref.watch()` vs `ref.read()` |
| **UI freezes on long list** | Implement pagination or virtual scrolling |
| **Socket.IO disconnects** | Check network connectivity provider |

---

## 📊 Metrics to Track

### **Performance Targets**

```
✅ Target | Current
─────────────────────
< 500ms  | Screen load time
< 200ms  | API response
60 FPS   | Animations
< 50MB   | Bundle size
> 80%    | Test coverage
> 90     | Lighthouse score
```

### **Weekly Metrics**

```
Week [N]:
├── Screens completed: [X]/[Y]
├── Tests written: [X]
├── Bugs fixed: [X]
├── Performance score: [X]/100
└── Team velocity: [X] story points
```

---

## 🎯 Success Criteria

### **Each Feature Should Have:**

- [x] User story/acceptance criteria
- [x] Task breakdown
- [x] Estimated effort
- [x] Test cases
- [x] Documentation
- [x] PR review

### **Before Merge:**

- [x] Code compiles
- [x] Tests pass
- [x] Linter passes
- [x] No console errors
- [x] Mobile responsive
- [x] PR approved

---

## 📞 Communication

### **Daily Standup**
- **Time:** 10:00 AM (Vietnam time)
- **Duration:** 15 minutes
- **Format:** What done/doing/blocked

### **Sprint Review**
- **Time:** Friday 4:00 PM
- **Duration:** 30 minutes
- **Attendees:** Team + Stakeholders

### **Slack Channels**
- `#lms-dev` - Development
- `#lms-design` - Design
- `#lms-bugs` - Issues
- `#lms-releases` - Releases

---

## 🚀 Launch Checklist

### **Before Deploy**

- [ ] All tests passing
- [ ] No critical bugs
- [ ] Performance benchmarks met
- [ ] Documentation updated
- [ ] Build size acceptable
- [ ] Security audit passed
- [ ] Accessibility checked
- [ ] Stakeholders approved

### **During Deploy**

- [ ] Monitor server logs
- [ ] Monitor crash reports
- [ ] Check performance metrics
- [ ] User feedback

### **After Deploy**

- [ ] Monitor analytics
- [ ] Respond to issues
- [ ] Gather feedback
- [ ] Plan next sprint

---

## 📱 Testing on Device

```bash
# Run on connected device
flutter run

# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android

# Run on web
flutter run -d chrome

# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

---

## 🎓 Learning Resources

- **Flutter Docs:** https://flutter.dev/docs
- **Riverpod Docs:** https://riverpod.dev
- **Dart Docs:** https://dart.dev/docs
- **Clean Architecture:** https://resocoder.com/flutter-clean-architecture
- **Testing Guide:** https://flutter.dev/docs/testing

---

## ✅ Checklist for Today

- [ ] Read `Screens.md` (Important!)
- [ ] Read `NEXT_STEPS.md` (Roadmap)
- [ ] Setup development environment
- [ ] Run the app locally
- [ ] Review task assignments
- [ ] Ask questions if unclear

---

## 🎯 Remember

**Key Principles:**
1. **User First** - Always think about user experience
2. **Quality Code** - Write tests, use best practices
3. **Communication** - Ask if unsure, share progress
4. **Iterate** - Ship small, get feedback, improve
5. **Have Fun** - This is an awesome project! 🎉

---

**Good luck! Let's build something amazing! 🚀**

---

Questions? Check these files first:
- `Screens.md` - Feature specs
- `NEXT_STEPS.md` - Development roadmap
- `DESIGN_ANALYSIS_SUMMARY.md` - Project overview
- `IMPLEMENTATION_SUMMARY.md` - Technical details

Or ask on Slack: `#lms-dev`

---

Last Updated: October 17, 2025
