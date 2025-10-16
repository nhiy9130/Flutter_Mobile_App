# UI/UX Development Guide for LMS Flutter App

## 📋 Tổng quan

Tài liệu này mô tả quá trình phát triển và tối ưu hóa UI/UX cho hệ thống LMS mobile Flutter, bao gồm thiết kế Design System, Common Components và các màn hình chính.

## 🎨 Design System

### 1. Colors (AppColors)
**File:** `lib/core/theme/app_colors.dart`

**Bảng màu chính:**
- **Primary:** `#6366F1` (Indigo-500) - Màu chủ đạo
- **Secondary:** `#8B5CF6` (Purple-500) - Màu phụ
- **Accent:** `#06B6D4` (Cyan-500) - Màu nhấn
- **Success:** `#10B981` (Emerald-500)
- **Warning:** `#F59E0B` (Amber-500)
- **Error:** `#EF4444` (Red-500)

**Role-based Colors:**
- **Admin:** `#DC2626` (Red-600)
- **Teacher:** `#059669` (Emerald-600)
- **Student:** `#2563EB` (Blue-600)

**Gradients:** Sử dụng LinearGradient cho các elements quan trọng

### 2. Typography (AppTypography)
**File:** `lib/core/theme/app_typography.dart`

**Hệ thống typography:**
- **Display styles:** display1, display2, display3 (48px, 40px, 36px)
- **Headings:** h1-h6 (32px xuống 16px)
- **Body text:** bodyLarge, bodyMedium, bodySmall (18px, 16px, 14px)
- **Labels:** labelLarge, labelMedium, labelSmall với font weight 500-600
- **Special styles:** link, code, success, warning, error

### 3. Spacing & Dimensions (AppDimensions)
**File:** `lib/core/theme/app_dimensions.dart`

**Base unit:** 8px - Tất cả spacing đều là bội số của 8

**Spacing scale:**
- xs2: 2px, xs: 4px
- sm: 8px, md: 16px, lg: 24px, xl: 32px
- xl2: 40px, xl3: 48px, xl4: 64px, xl5: 80px, xl6: 96px

**Component sizes:**
- Icons: 12px-64px
- Buttons: 36px-52px height
- Avatars: 32px-96px
- Border radius: 4px-24px

## 🧩 Common UI Components

### 1. CustomButton
**File:** `lib/core/widgets/custom_button.dart`

**Variants:**
- `primary` - Nút chính với màu primary
- `secondary` - Nút phụ với màu secondary  
- `outline` - Nút viền
- `ghost` - Nút trong suốt
- `destructive` - Nút xóa/hủy
- `success` - Nút thành công
- `warning` - Nút cảnh báo

**Sizes:** small, medium, large

**Features:**
- Loading state với spinner
- Icon support (leading/trailing)
- Expanded width option
- Disabled state
- Hover/pressed effects

### 2. CustomTextField
**File:** `lib/core/widgets/custom_text_field.dart`

**Variants:**
- `outlined` - Viền rõ ràng (default)
- `filled` - Nền màu
- `underlined` - Chỉ có gạch dưới

**Features:**
- Label và hint text
- Prefix/suffix icons
- Error handling với validation
- Password visibility toggle
- Helper text
- Focus state management

### 3. CustomCards
**File:** `lib/core/widgets/custom_cards.dart`

**Card types:**
- **CustomCard** - Base card component
- **InfoCard** - Hiển thị thông tin với icon
- **StatCard** - Thống kê với trend indicators
- **ActionCard** - Card có thể tap với trailing icon
- **ProgressCard** - Hiển thị tiến độ với progress bar

### 4. Loading Indicators
**File:** `lib/core/widgets/loading_indicators.dart`

**Types:**
- `circular` - Circular progress indicator
- `linear` - Linear progress bar
- `dots` - Animated dots
- `pulse` - Pulsing circle

**Features:**
- LoadingOverlay cho full screen
- ShimmerLoading effect
- Customizable colors và sizes

## 📱 Auth Screens

### 1. Login Screen
**File:** `lib/screens/auth/login_screen.dart`

**Improvements:**
- Modern gradient header với logo
- Demo info card
- Form validation
- Password visibility toggle
- Quick login buttons cho demo accounts
- Forgot password link
- Remember me checkbox
- Footer links (register, help, privacy)

### 2. Register Screen  
**File:** `lib/screens/auth/register_screen.dart`

**Features:**
- Role selection (Student/Teacher)
- Multi-step form với validation
- Personal information section
- Password strength validation
- Terms & conditions checkbox
- Phone number field
- Success feedback

### 3. Forgot Password Screen
**File:** `lib/screens/auth/forgot_password_screen.dart`

**Flow:**
- Email input với validation
- Success state sau khi gửi
- Resend email option
- Support contact info
- Back to login navigation

## 📊 Dashboard Improvements

### Student Dashboard
**File:** `lib/screens/dashboard/student_dashboard.dart`

**Sections:**
1. **Welcome Card** - Greeting dựa theo thời gian
2. **Quick Actions** - 4 action cards chính
3. **Learning Progress** - Progress cards cho courses
4. **Analytics** - 4 stat cards với trends
5. **Recommendations** - Gợi ý courses

**UX Enhancements:**
- Role-based color theming
- Dynamic greetings
- Badge indicators cho notifications
- Trend visualizations
- Interactive cards

## 🛠 Usage Examples

### Sử dụng CustomButton:
```dart
CustomButton(
  onPressed: () => handleLogin(),
  text: 'Đăng nhập',
  variant: ButtonVariant.primary,
  size: ButtonSize.large,
  icon: Icons.login,
  isLoading: isLoading,
  isExpanded: true,
)
```

### Sử dụng CustomTextField:
```dart
CustomTextField(
  controller: emailController,
  label: 'Email',
  hint: 'Nhập email của bạn',
  prefixIcon: Icon(Icons.email_outlined),
  validator: (value) => validateEmail(value),
  keyboardType: TextInputType.emailAddress,
)
```

### Sử dụng StatCard:
```dart
StatCard(
  title: 'Thời gian học',
  value: '124h',
  icon: Icons.access_time,
  trend: TrendDirection.up,
  trendValue: '+12%',
  valueColor: AppColors.primary,
)
```

## 🎯 Best Practices

### 1. Consistency
- Luôn sử dụng AppColors thay vì hardcode colors
- Sử dụng AppSpacing cho consistent spacing
- Follow typography scale từ AppTypography

### 2. Accessibility
- Đủ contrast ratio cho text
- Touch targets tối thiểu 44px
- Meaningful semantic labels
- Support cho screen readers

### 3. Performance
- Sử dụng const constructors khi có thể
- Lazy loading cho heavy components
- Optimize image loading
- Minimize rebuilds

### 4. Responsive Design
- Test trên các screen sizes khác nhau
- Sử dụng MediaQuery và LayoutBuilder
- Flexible layouts với Flex widgets
- Breakpoints cho tablet/desktop

## 🔄 Migration Guide

### Migrate từ old widgets:
1. **Old buttons** → `CustomButton`
2. **Old TextFields** → `CustomTextField`  
3. **Old Cards** → Custom card variants
4. **Hard-coded colors** → `AppColors`
5. **Inconsistent spacing** → `AppSpacing`

### Steps:
1. Import new theme files
2. Replace old widgets từng cái một
3. Update colors và spacing
4. Test trên multiple devices
5. Validate accessibility

## 📈 Future Enhancements

### Planned Features:
1. **Dark theme support** - Complete dark mode
2. **Animation system** - Consistent animations
3. **Advanced components** - Charts, calendars, rich text
4. **Localization** - Multi-language support
5. **Accessibility** - Screen reader optimization
6. **Performance** - Code splitting, lazy loading

### Component Roadmap:
- DatePicker components
- Chart/Graph widgets
- Rich text editor
- Advanced form components
- Navigation components
- Media players

---

## 🚀 Quick Start

1. Import design system:
```dart
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/theme/app_typography.dart';
```

2. Import widgets:
```dart
import '../../core/widgets/widgets.dart';
```

3. Use consistent patterns:
```dart
// Spacing
const SizedBox(height: AppSpacing.md)

// Colors  
color: AppColors.primary

// Typography
style: AppTypography.h6
```

4. Follow component structure từ existing examples

**Lưu ý:** Đây là foundation cho scalable và maintainable UI system. Tiếp tục build thêm components theo patterns đã thiết lập.