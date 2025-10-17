# 🔄 SCREENS REFACTOR PLAN - Cấu Trúc Mới

**Ngày tạo:** October 17, 2025  
**Trạng thái:** 📋 Ready to Execute  
**Mục đích:** Tổ chức lại screens theo role-based architecture

---

## 📊 Vấn Đề Hiện Tại

### **Current Structure (Lộn Xộn)**
```
lib/screens/
├── dashboard_screen.dart (ROOT - Wrong!)
├── home_screen.dart (ROOT)
├── profile_screen.dart (ROOT)
├── settings_screen.dart (ROOT)
├── livestream_screen.dart (ROOT)
├── notifications_*.dart (ROOT)
├── admin/
│   ├── admin_dashboard_screen.dart
│   ├── course_management_screen.dart
│   ├── system_settings_screen.dart
│   └── user_management_screen.dart
├── auth/
│   ├── login_screen.dart
│   ├── register_screen.dart
│   └── forgot_password_screen.dart
├── courses/
│   └── courses_screen.dart
├── course_detail/
│   ├── chat_tab.dart
│   ├── course_detail_screen.dart
│   ├── files_tab.dart
│   └── quizzes_tab.dart
├── dashboard/
│   ├── admin_dashboard.dart
│   ├── student_dashboard.dart
│   └── teacher_dashboard.dart
├── livestream/
│   └── livestream_screen.dart
├── teacher/
│   ├── quiz_creation_screen.dart
│   ├── student_management_screen.dart
│   ├── teacher_courses_screen.dart
│   └── teacher_dashboard_screen.dart
└── viewers/
    ├── pdf_viewer_screen.dart
    └── video_viewer_screen.dart
```

### **Issues:**
- ❌ `dashboard_screen.dart` ở root (không rõ vai trò)
- ❌ `root_shell.dart` không có folder
- ❌ Screens mix lẫn trong admin/, không phân tách student/teacher
- ❌ course_detail là shared nhưng để riêng
- ❌ livestream folder trùng với root file
- ❌ notification screens ở root không organize
- ❌ Khó maintain & scale

---

## ✅ Cấu Trúc Mới (Proposed)

### **New Structure (Clean & Organized)**

```
lib/screens/
│
├── 📁 common/ (Shared UI - Auth + Layout)
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   │
│   ├── root_shell.dart
│   ├── not_found_screen.dart
│   └── home_screen.dart
│
├── 📁 shared/ (Cross-role Features)
│   ├── profile/
│   │   ├── profile_screen.dart
│   │   └── profile_edit_screen.dart
│   │
│   ├── settings/
│   │   └── settings_screen.dart
│   │
│   ├── notifications/
│   │   ├── notifications_screen.dart
│   │   ├── notifications_prefs_screen.dart
│   │   └── notification_detail_screen.dart
│   │
│   ├── livestream/
│   │   └── livestream_screen.dart
│   │
│   └── viewers/
│       ├── pdf_viewer_screen.dart
│       ├── video_viewer_screen.dart
│       └── document_viewer_screen.dart
│
├── 📁 student/ (Student Only Screens)
│   ├── dashboard/
│   │   └── student_dashboard.dart
│   │
│   ├── courses/
│   │   ├── student_courses_screen.dart
│   │   └── course_detail/
│   │       ├── course_detail_screen.dart
│   │       ├── course_content_tab.dart
│   │       ├── course_assignment_tab.dart
│   │       ├── course_quiz_tab.dart
│   │       ├── course_chat_tab.dart
│   │       ├── course_files_tab.dart
│   │       ├── course_grades_tab.dart
│   │       └── course_overview_tab.dart
│   │
│   ├── calendar/
│   │   └── calendar_screen.dart
│   │
│   ├── grades/
│   │   └── student_grades_screen.dart
│   │
│   └── assignments/
│       ├── assignments_screen.dart
│       └── assignment_detail_screen.dart
│
├── 📁 teacher/ (Teacher Only Screens)
│   ├── dashboard/
│   │   └── teacher_dashboard.dart
│   │
│   ├── courses/
│   │   ├── teacher_courses_screen.dart
│   │   ├── course_management/
│   │   │   ├── course_edit_screen.dart
│   │   │   └── course_detail_screen.dart
│   │   │
│   │   └── content_management/
│   │       ├── create_lesson_screen.dart
│   │       └── upload_material_screen.dart
│   │
│   ├── quiz/
│   │   ├── quiz_list_screen.dart
│   │   ├── quiz_creation_screen.dart
│   │   ├── quiz_edit_screen.dart
│   │   └── quiz_preview_screen.dart
│   │
│   ├── gradebook/
│   │   ├── gradebook_screen.dart
│   │   ├── grade_entry_screen.dart
│   │   └── feedback_screen.dart
│   │
│   ├── students/
│   │   ├── student_management_screen.dart
│   │   ├── student_detail_screen.dart
│   │   └── attendance_screen.dart
│   │
│   ├── assignments/
│   │   ├── assignments_screen.dart
│   │   ├── assignment_creation_screen.dart
│   │   └── submission_review_screen.dart
│   │
│   ├── analytics/
│   │   ├── analytics_screen.dart
│   │   ├── class_performance_screen.dart
│   │   └── student_progress_screen.dart
│   │
│   └── messaging/
│       └── messaging_screen.dart
│
└── 📁 admin/ (Admin Only Screens)
    ├── dashboard/
    │   └── admin_dashboard.dart
    │
    ├── users/
    │   ├── user_management_screen.dart
    │   ├── user_detail_screen.dart
    │   ├── user_create_screen.dart
    │   └── role_management_screen.dart
    │
    ├── courses/
    │   ├── course_management_screen.dart
    │   ├── course_approval_screen.dart
    │   └── course_analytics_screen.dart
    │
    ├── analytics/
    │   ├── system_analytics_screen.dart
    │   ├── usage_stats_screen.dart
    │   └── reports_screen.dart
    │
    ├── system/
    │   ├── system_settings_screen.dart
    │   ├── backup_screen.dart
    │   ├── maintenance_screen.dart
    │   └── logs_screen.dart
    │
    └── moderation/
        ├── content_moderation_screen.dart
        ├── user_reports_screen.dart
        └── dispute_resolution_screen.dart
```

---

## 🎯 Lợi Ích Cấu Trúc Mới

### **1. Better Organization**
```
✅ Clear role separation (student/teacher/admin)
✅ Shared features in own folder (common/shared)
✅ Logical grouping by feature within each role
✅ Easy to find related screens
```

### **2. Easier Maintenance**
```
✅ One role doesn't affect others
✅ Easy to add new screens
✅ Clear dependencies
✅ Better for code review
```

### **3. Better Scaling**
```
✅ Can add new roles (e.g., /parent, /moderator)
✅ Can split roles into separate features
✅ Feature flags easier to implement
✅ Conditional compilation possible
```

### **4. Better Code Reuse**
```
✅ Shared components in /shared
✅ Common auth in /common
✅ Role-specific widgets in role folders
✅ Clear separation of concerns
```

---

## 📋 Migration Steps

### **Phase 1: Create New Folder Structure (No Changes)**

```bash
# Create new directories
mkdir lib/screens/common
mkdir lib/screens/common/auth
mkdir lib/screens/common/root

mkdir lib/screens/shared
mkdir lib/screens/shared/profile
mkdir lib/screens/shared/settings
mkdir lib/screens/shared/notifications
mkdir lib/screens/shared/livestream
mkdir lib/screens/shared/viewers

# Copy student folder (already exists)
# mkdir lib/screens/student
# mkdir lib/screens/student/dashboard
# mkdir lib/screens/student/courses
# mkdir lib/screens/student/courses/course_detail
# mkdir lib/screens/student/calendar
# mkdir lib/screens/student/grades
# mkdir lib/screens/student/assignments

# Copy teacher folder (already exists)
# mkdir lib/screens/teacher
# ...

# Copy admin folder (already exists)
# mkdir lib/screens/admin
# ...
```

---

### **Phase 2: Move Files to New Locations**

#### **A. Auth Files → common/auth**
```
auth/login_screen.dart → common/auth/login_screen.dart
auth/register_screen.dart → common/auth/register_screen.dart
auth/forgot_password_screen.dart → common/auth/forgot_password_screen.dart
```

#### **B. Root Shell → common/root**
```
root_shell.dart → common/root_shell.dart
home_screen.dart → common/home_screen.dart
not_found_screen.dart → common/not_found_screen.dart
```

#### **C. Shared Features → shared/**
```
profile_screen.dart → shared/profile/profile_screen.dart
settings_screen.dart → shared/settings/settings_screen.dart
notifications_screen.dart → shared/notifications/notifications_screen.dart
notifications_prefs_screen.dart → shared/notifications/notifications_prefs_screen.dart
livestream_screen.dart → shared/livestream/livestream_screen.dart
viewers/ → shared/viewers/
```

#### **D. Organize Student Screens**
```
courses/courses_screen.dart → student/courses/student_courses_screen.dart
course_detail/ → student/courses/course_detail/
```

#### **E. Organize Teacher Screens**
```
teacher/teacher_dashboard_screen.dart → teacher/dashboard/teacher_dashboard.dart
teacher/teacher_courses_screen.dart → teacher/courses/teacher_courses_screen.dart
teacher/quiz_creation_screen.dart → teacher/quiz/quiz_creation_screen.dart
teacher/student_management_screen.dart → teacher/students/student_management_screen.dart
```

#### **F. Admin Screens (Reorganize)**
```
admin/admin_dashboard_screen.dart → admin/dashboard/admin_dashboard.dart
admin/user_management_screen.dart → admin/users/user_management_screen.dart
admin/course_management_screen.dart → admin/courses/course_management_screen.dart
admin/system_settings_screen.dart → admin/system/system_settings_screen.dart
```

---

### **Phase 3: Update Imports in app_router.dart**

**Before:**
```dart
import '../screens/auth/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/dashboard/student_dashboard.dart';
import '../screens/dashboard/teacher_dashboard.dart';
import '../screens/dashboard/admin_dashboard.dart';
```

**After:**
```dart
import '../screens/common/auth/login_screen.dart';
import '../screens/shared/profile/profile_screen.dart';
import '../screens/student/dashboard/student_dashboard.dart';
import '../screens/teacher/dashboard/teacher_dashboard.dart';
import '../screens/admin/dashboard/admin_dashboard.dart';
```

---

### **Phase 4: Update Dashboard Screen Selection**

**Create:** `lib/screens/shared/dashboard/dashboard_dispatcher.dart`

```dart
/// Dispatcher to show correct dashboard based on role
class DashboardDispatcher extends ConsumerWidget {
  const DashboardDispatcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.user;
    
    if (user == null) {
      return const HomeScreen();
    }

    switch (user.role) {
      case UserRole.student:
        return const StudentDashboard();
      case UserRole.teacher:
        return const TeacherDashboard();
      case UserRole.admin:
        return const AdminDashboard();
      default:
        return const NotFoundScreen();
    }
  }
}
```

Then in router:
```dart
GoRoute(
  path: '/dashboard',
  builder: (context, state) => const DashboardDispatcher(),
),
```

---

### **Phase 5: Update All Import Statements**

**Files to Update:**
- `lib/routes/app_router.dart` - Main router
- `lib/app.dart` - If imports screens
- `lib/screens/common/root_shell.dart` - Shell imports
- Any screens that import other screens

**Find & Replace Pattern:**
```
OLD: import '../screens/profile_screen.dart'
NEW: import '../screens/shared/profile/profile_screen.dart'

OLD: import '../../screens/courses/courses_screen.dart'
NEW: import '../../screens/student/courses/student_courses_screen.dart'

OLD: import '../teacher/quiz_creation_screen.dart'
NEW: import '../teacher/quiz/quiz_creation_screen.dart'
```

---

## 📁 File Migration Checklist

### **Common/Auth (3 files)**
- [ ] `auth/login_screen.dart` → `common/auth/login_screen.dart`
- [ ] `auth/register_screen.dart` → `common/auth/register_screen.dart`
- [ ] `auth/forgot_password_screen.dart` → `common/auth/forgot_password_screen.dart`

### **Common/Root (3 files)**
- [ ] `root_shell.dart` → `common/root_shell.dart`
- [ ] `home_screen.dart` → `common/home_screen.dart`
- [ ] `not_found_screen.dart` → `common/not_found_screen.dart`

### **Shared/Profile (1 file)**
- [ ] `profile_screen.dart` → `shared/profile/profile_screen.dart`

### **Shared/Settings (1 file)**
- [ ] `settings_screen.dart` → `shared/settings/settings_screen.dart`

### **Shared/Notifications (2 files)**
- [ ] `notifications_screen.dart` → `shared/notifications/notifications_screen.dart`
- [ ] `notifications_prefs_screen.dart` → `shared/notifications/notifications_prefs_screen.dart`

### **Shared/Livestream (1 file)**
- [ ] `livestream_screen.dart` → `shared/livestream/livestream_screen.dart`

### **Shared/Viewers (2 files)**
- [ ] `viewers/pdf_viewer_screen.dart` → `shared/viewers/pdf_viewer_screen.dart`
- [ ] `viewers/video_viewer_screen.dart` → `shared/viewers/video_viewer_screen.dart`

### **Student/* (Already good structure, minor renames)**
- [ ] `courses/courses_screen.dart` → `student/courses/student_courses_screen.dart`
- [ ] `dashboard/student_dashboard.dart` → `student/dashboard/student_dashboard.dart`
- [ ] Add: `student/calendar/calendar_screen.dart` (NEW)
- [ ] Add: `student/grades/student_grades_screen.dart` (NEW)
- [ ] Add: `student/assignments/assignments_screen.dart` (NEW)

### **Teacher/* (Reorganize deeply)**
- [ ] `teacher/teacher_dashboard_screen.dart` → `teacher/dashboard/teacher_dashboard.dart`
- [ ] `teacher/teacher_courses_screen.dart` → `teacher/courses/teacher_courses_screen.dart`
- [ ] `teacher/quiz_creation_screen.dart` → `teacher/quiz/quiz_creation_screen.dart`
- [ ] `teacher/student_management_screen.dart` → `teacher/students/student_management_screen.dart`

### **Admin/** (Reorganize deeply)
- [ ] `admin/admin_dashboard_screen.dart` → `admin/dashboard/admin_dashboard.dart`
- [ ] `admin/user_management_screen.dart` → `admin/users/user_management_screen.dart`
- [ ] `admin/course_management_screen.dart` → `admin/courses/course_management_screen.dart`
- [ ] `admin/system_settings_screen.dart` → `admin/system/system_settings_screen.dart`

### **Router & Core Updates**
- [ ] Update `lib/routes/app_router.dart` - All imports
- [ ] Update `lib/app.dart` - If has imports
- [ ] Create `shared/dashboard/dashboard_dispatcher.dart` (NEW)
- [ ] Update all screen-to-screen imports

---

## 🔧 Post-Refactor Actions

### **1. Verify Imports**
```bash
# Check for compile errors
flutter analyze

# Check for unused imports
dart fix --dry-run
```

### **2. Test Navigation**
```bash
# Run app and test all routes
flutter run

# Test flow:
- Login as Student
- Navigate to dashboard (should show StudentDashboard)
- Login as Teacher
- Navigate to dashboard (should show TeacherDashboard)
- Login as Admin
- Navigate to dashboard (should show AdminDashboard)
```

### **3. Verify All Screens Load**
- [ ] Auth screens (login, register, forgot)
- [ ] Student screens (dashboard, courses, calendar, grades)
- [ ] Teacher screens (dashboard, courses, quiz, gradebook, students)
- [ ] Admin screens (dashboard, users, courses, system)
- [ ] Shared screens (profile, settings, notifications, livestream)

### **4. Format Code**
```bash
dart format lib/
```

---

## 📝 Summary

| Aspect | Before | After |
|--------|--------|-------|
| **Folder Levels** | Chaotic | 2-3 levels, clear |
| **Role Clarity** | Mixed | Separated |
| **New Features** | Hard to place | Clear location |
| **Scaling** | Difficult | Easy |
| **Maintenance** | Complex | Simple |
| **Developer Time** | High | Low |

---

## 🎯 Success Criteria

- [ ] All 30+ screens moved to correct locations
- [ ] All imports updated correctly
- [ ] App compiles without errors
- [ ] All routes work correctly
- [ ] Dashboard dispatcher shows correct role dashboard
- [ ] No performance regressions
- [ ] Tests pass (if any)

---

## 📅 Timeline

| Phase | Duration | Status |
|-------|----------|--------|
| **1. Create folders** | 15 min | Ready |
| **2. Move files** | 30 min | Ready |
| **3. Update imports** | 45 min | Ready |
| **4. Update router** | 20 min | Ready |
| **5. Test & verify** | 30 min | Ready |
| **TOTAL** | ~2.5 hours | Ready |

---

## 🚀 Next Steps

1. ✅ Review this structure with team
2. ⏳ Execute file movements
3. ⏳ Update import statements
4. ⏳ Test on device
5. ⏳ Commit to version control

---

**Prepared for:** Team Developers  
**Date:** October 17, 2025  
**Status:** 📋 READY TO EXECUTE

