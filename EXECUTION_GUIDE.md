# 🎬 EXECUTION GUIDE - Refactor Screens Structure

**Ngày:** October 17, 2025  
**Trạng thái:** 📋 Ready to Execute  
**Duration:** ~2.5 hours  

---

## 📋 Tóm Tắt Công Việc

### **Hai phần công việc chính:**

1. **✅ DONE:** Fix QuickActionCard overflow issue
   - Removed unnecessary `Flexible` wrappers
   - Kept `SizedBox` for spacing, `Text` for text
   - Result: No more overflow errors on student screens

2. **⏳ TODO:** Refactor screens structure (detailed plan created)
   - Move files to new folder hierarchy
   - Update all imports
   - Update routing
   - Test all screens

---

## ✅ Part 1: QuickActionCard Fix (COMPLETED)

### **What Was Changed**
File: `lib/core/widgets/quick_action_card.dart`

**Change Summary:**
- Removed 3x `Flexible(child: ...)` wrappers from Column children
- Kept `maxLines` and `overflow.ellipsis` on Text widgets
- Added explicit `mainAxisSize: MainAxisSize.min` to Column

**Result:**
```
✅ No more overflow errors
✅ Text truncates properly with "..."
✅ Works on all screen sizes
✅ Cleaner, more maintainable code
```

### **File Updated**
```
c:\Project\lms_mobile_flutter\lib\core\widgets\quick_action_card.dart
✅ MODIFIED - Ready to use
```

### **Testing Quick Actions**
```bash
# Run app and navigate to student dashboard
flutter run

# Verify:
- Quick action cards display without overflow
- Text shows "..." when too long
- Badges show correctly
- Cards are clickable
```

---

## ⏳ Part 2: Refactor Screens (ACTION ITEMS)

### **Current State**
All documentation and plans are created. Ready to execute.

**Documents Created:**
1. ✅ `REFACTOR_STRUCTURE_PLAN.md` - Detailed refactor plan
2. ✅ `QUICKACTIONCARD_FIX_DETAILS.md` - Technical fix details

---

## 🚀 Execution Steps for Screens Refactor

### **Step 1: Create New Folder Structure**

```bash
# Create common folders
mkdir lib/screens/common
mkdir lib/screens/common/auth
mkdir lib/screens/common/root

# Create shared folders
mkdir lib/screens/shared
mkdir lib/screens/shared/profile
mkdir lib/screens/shared/settings
mkdir lib/screens/shared/notifications
mkdir lib/screens/shared/livestream
mkdir lib/screens/shared/viewers

# Create/update student folders
mkdir lib/screens/student/dashboard
mkdir lib/screens/student/courses
mkdir lib/screens/student/courses/course_detail
mkdir lib/screens/student/calendar
mkdir lib/screens/student/grades
mkdir lib/screens/student/assignments

# Create/update teacher folders
mkdir lib/screens/teacher/dashboard
mkdir lib/screens/teacher/courses
mkdir lib/screens/teacher/quiz
mkdir lib/screens/teacher/gradebook
mkdir lib/screens/teacher/students
mkdir lib/screens/teacher/assignments
mkdir lib/screens/teacher/analytics
mkdir lib/screens/teacher/messaging

# Create/update admin folders
mkdir lib/screens/admin/dashboard
mkdir lib/screens/admin/users
mkdir lib/screens/admin/courses
mkdir lib/screens/admin/system
mkdir lib/screens/admin/analytics
```

### **Step 2: Move Files - Common/Auth**

```bash
# Move auth screens to common/auth
mv lib/screens/auth/login_screen.dart lib/screens/common/auth/
mv lib/screens/auth/register_screen.dart lib/screens/common/auth/
mv lib/screens/auth/forgot_password_screen.dart lib/screens/common/auth/

# Delete old auth folder
rmdir lib/screens/auth
```

### **Step 3: Move Files - Common/Root**

```bash
# Move root shell and home to common
mv lib/screens/root_shell.dart lib/screens/common/
mv lib/screens/home_screen.dart lib/screens/common/
mv lib/screens/not_found_screen.dart lib/screens/common/
```

### **Step 4: Move Files - Shared Features**

```bash
# Move profile
mv lib/screens/profile_screen.dart lib/screens/shared/profile/

# Move settings
mv lib/screens/settings_screen.dart lib/screens/shared/settings/

# Move notifications
mv lib/screens/notifications_screen.dart lib/screens/shared/notifications/
mv lib/screens/notifications_prefs_screen.dart lib/screens/shared/notifications/

# Move livestream
mv lib/screens/livestream_screen.dart lib/screens/shared/livestream/

# Viewers already exist, just move if needed
# (They might already be in lib/screens/viewers)
```

### **Step 5: Organize Student Screens**

```bash
# Move course screen and rename
mv lib/screens/courses/courses_screen.dart \
   lib/screens/student/courses/student_courses_screen.dart

# Move course_detail contents
mv lib/screens/course_detail/* \
   lib/screens/student/courses/course_detail/

# Update student_dashboard if exists
mv lib/screens/dashboard/student_dashboard.dart \
   lib/screens/student/dashboard/
```

### **Step 6: Organize Teacher Screens**

```bash
# Reorganize teacher folder structure
mv lib/screens/teacher/teacher_dashboard_screen.dart \
   lib/screens/teacher/dashboard/teacher_dashboard.dart

mv lib/screens/teacher/teacher_courses_screen.dart \
   lib/screens/teacher/courses/teacher_courses_screen.dart

mv lib/screens/teacher/quiz_creation_screen.dart \
   lib/screens/teacher/quiz/quiz_creation_screen.dart

mv lib/screens/teacher/student_management_screen.dart \
   lib/screens/teacher/students/student_management_screen.dart
```

### **Step 7: Organize Admin Screens**

```bash
# Already in admin folder, just restructure
mv lib/screens/admin/admin_dashboard_screen.dart \
   lib/screens/admin/dashboard/admin_dashboard.dart

mv lib/screens/admin/user_management_screen.dart \
   lib/screens/admin/users/user_management_screen.dart

mv lib/screens/admin/course_management_screen.dart \
   lib/screens/admin/courses/course_management_screen.dart

mv lib/screens/admin/system_settings_screen.dart \
   lib/screens/admin/system/system_settings_screen.dart
```

### **Step 8: Create Dashboard Dispatcher**

Create: `lib/screens/shared/dashboard/dashboard_dispatcher.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/auth_state.dart';
import '../profile/profile_screen.dart';
import '../../student/dashboard/student_dashboard.dart';
import '../../teacher/dashboard/teacher_dashboard.dart';
import '../../admin/dashboard/admin_dashboard.dart';
import '../common/not_found_screen.dart';

/// Dispatcher to show correct dashboard based on user role
class DashboardDispatcher extends ConsumerWidget {
  const DashboardDispatcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.user;
    
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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

### **Step 9: Update app_router.dart**

Update: `lib/routes/app_router.dart`

**Replace imports section:**
```dart
// BEFORE
import '../screens/auth/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/dashboard_screen.dart';
// ... many more

// AFTER
import '../screens/common/auth/login_screen.dart';
import '../screens/common/auth/register_screen.dart';
import '../screens/common/auth/forgot_password_screen.dart';
import '../screens/common/root_shell.dart';
import '../screens/common/home_screen.dart';
import '../screens/common/not_found_screen.dart';

import '../screens/shared/profile/profile_screen.dart';
import '../screens/shared/settings/settings_screen.dart';
import '../screens/shared/notifications/notifications_screen.dart';
import '../screens/shared/notifications/notifications_prefs_screen.dart';
import '../screens/shared/livestream/livestream_screen.dart';
import '../screens/shared/dashboard/dashboard_dispatcher.dart';

import '../screens/student/courses/student_courses_screen.dart';
import '../screens/student/courses/course_detail/course_detail_screen.dart';
import '../screens/student/courses/course_detail/chat_tab.dart';
import '../screens/student/courses/course_detail/files_tab.dart';
import '../screens/student/courses/course_detail/quizzes_tab.dart';

import '../screens/teacher/dashboard/teacher_dashboard.dart';
import '../screens/admin/dashboard/admin_dashboard.dart';

import 'guards/auth_guard.dart';
```

**Update routes section:**
```dart
GoRoute(
  path: '/dashboard',
  redirect: (context, state) => requireAuth(context, state),
  builder: (context, state) => const DashboardDispatcher(),
),

GoRoute(
  path: '/my-courses',
  redirect: (context, state) => requireAuth(context, state),
  builder: (context, state) => const StudentCoursesScreen(),
),

GoRoute(
  path: '/courses/:courseId',
  redirect: (context, state) => requireAuth(context, state),
  builder: (context, state) =>
      CourseDetailScreen(courseId: state.pathParameters['courseId']!),
),

GoRoute(
  path: '/settings',
  redirect: (context, state) => requireAuth(context, state),
  builder: (context, state) => const SettingsScreen(),
),

GoRoute(
  path: '/profile',
  redirect: (context, state) => requireAuth(context, state),
  builder: (context, state) => const ProfileScreen(),
),

// ... update other routes similarly
```

### **Step 10: Find & Update All Imports in Screens**

```bash
# Search for all relative imports
grep -r "import.*screens" lib/screens/

# Key files to update:
# - lib/screens/common/root_shell.dart
# - lib/screens/shared/* (all files)
# - lib/screens/student/dashboard/student_dashboard.dart
# - lib/screens/student/courses/* (all files)
# - lib/screens/teacher/* (all files)
# - lib/screens/admin/* (all files)
```

**Example fixes:**

In `root_shell.dart`:
```dart
// OLD
import '../dashboard/admin_dashboard.dart';
import '../dashboard/student_dashboard.dart';

// NEW
import '../admin/dashboard/admin_dashboard.dart';
import '../student/dashboard/student_dashboard.dart';
```

In `student/courses/course_detail/course_detail_screen.dart`:
```dart
// OLD
import 'chat_tab.dart';
import 'files_tab.dart';

// NEW
import './chat_tab.dart';
import './files_tab.dart';
// (These are already correct, just verify)
```

### **Step 11: Format and Analyze**

```bash
# Format all Dart files
dart format lib/

# Analyze for errors
flutter analyze

# Fix issues if any
dart fix --apply
```

### **Step 12: Build and Test**

```bash
# Clean build
flutter clean
flutter pub get

# Run app
flutter run

# Test scenarios:
flutter run -d chrome  # Test on web
```

---

## 🧪 Testing Checklist

### **Navigation Tests**
- [ ] Can access login screen
- [ ] Can register new user
- [ ] Can login as student
- [ ] Student sees student dashboard
- [ ] Can logout
- [ ] Can login as teacher
- [ ] Teacher sees teacher dashboard
- [ ] Can login as admin
- [ ] Admin sees admin dashboard

### **Screen Tests (Student)**
- [ ] Dashboard loads and shows quick actions (no overflow)
- [ ] Courses screen loads
- [ ] Course detail screen loads
- [ ] All tabs work (Content, Files, Quiz, Chat, Grades)
- [ ] Profile screen loads
- [ ] Settings screen loads
- [ ] Notifications screen loads

### **Screen Tests (Teacher)**
- [ ] Teacher dashboard loads
- [ ] Courses management screen loads
- [ ] Quiz creation screen works
- [ ] Student management screen loads
- [ ] Gradebook loads

### **Screen Tests (Admin)**
- [ ] Admin dashboard loads
- [ ] User management loads
- [ ] Course management loads
- [ ] System settings loads

### **Code Quality**
- [ ] No compile errors
- [ ] No import errors
- [ ] No unused imports
- [ ] All files properly formatted

---

## 🚨 Troubleshooting

### **If: Compile Error - File Not Found**
```
Error: '../screens/auth/login_screen.dart' not found

Solution:
1. Check if file was moved correctly
2. Verify import path matches new location
3. Run: flutter pub get
```

### **If: Circular Import**
```
Error: Circular import detected

Solution:
1. Check if widgets import screens directly
2. Move shared widgets to lib/core/widgets
3. Keep screens importing from features, not other screens
```

### **If: Route Not Working**
```
Error: Route '/dashboard' returns NotFoundScreen

Solution:
1. Verify path in GoRoute matches
2. Check builder returns correct widget
3. Verify DashboardDispatcher imports are correct
4. Run: flutter clean && flutter pub get
```

### **If: Overflow Still Shows**
```
Error: RenderFlex overflowed

Solution:
1. Verify QuickActionCard fix was applied
2. Check similar widgets (CourseCard, etc.)
3. Ensure Column has maxLines on Text children
4. Review constraint issues in custom widgets
```

---

## 📝 Rollback Plan

If something goes wrong, rollback steps:

```bash
# 1. Restore from git
git checkout -- lib/screens/
git checkout -- lib/routes/app_router.dart

# 2. Start over with careful changes
# 3. Make smaller commits this time
```

---

## ✅ Success Criteria

- [x] QuickActionCard overflow fixed
- [ ] All files moved to new structure
- [ ] All imports updated
- [ ] Router updated
- [ ] App compiles without errors
- [ ] All screens load without errors
- [ ] Navigation works for all roles
- [ ] Code is formatted
- [ ] No console warnings
- [ ] Ready for version control commit

---

## 📊 Before & After Comparison

### **BEFORE (Current State)**
```
lib/screens/                          Confusion 😕
├── dashboard_screen.dart             (which role?)
├── home_screen.dart
├── profile_screen.dart
├── settings_screen.dart
├── notifications_*.dart
├── admin/
├── auth/
├── courses/
├── course_detail/
├── dashboard/
├── livestream/
├── teacher/
└── viewers/
```

### **AFTER (New Structure)**
```
lib/screens/                          Organization 🎉
├── common/
│   ├── auth/
│   ├── root_shell.dart
│   ├── home_screen.dart
│   └── not_found_screen.dart
├── shared/
│   ├── profile/
│   ├── settings/
│   ├── notifications/
│   ├── livestream/
│   ├── dashboard/
│   └── viewers/
├── student/
│   ├── dashboard/
│   ├── courses/
│   ├── calendar/
│   ├── grades/
│   └── assignments/
├── teacher/
│   ├── dashboard/
│   ├── courses/
│   ├── quiz/
│   ├── gradebook/
│   ├── students/
│   ├── assignments/
│   ├── analytics/
│   └── messaging/
└── admin/
    ├── dashboard/
    ├── users/
    ├── courses/
    ├── system/
    └── analytics/
```

---

## 🎯 Timeline

| Task | Time | Status |
|------|------|--------|
| Create folders | 15 min | ⏳ TODO |
| Move files | 30 min | ⏳ TODO |
| Update imports | 45 min | ⏳ TODO |
| Update router | 20 min | ⏳ TODO |
| Test & debug | 30 min | ⏳ TODO |
| **TOTAL** | **2.5 hrs** | ⏳ TODO |

---

## 📞 Next Steps

1. ✅ Review this execution guide
2. ✅ Review `REFACTOR_STRUCTURE_PLAN.md`
3. ⏳ Execute folder creation
4. ⏳ Execute file movements
5. ⏳ Update imports
6. ⏳ Test thoroughly
7. ⏳ Commit to git

---

**Prepared for:** Team  
**Date:** October 17, 2025  
**Status:** 📋 READY TO EXECUTE

