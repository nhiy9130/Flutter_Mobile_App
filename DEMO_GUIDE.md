# LMS Mobile Flutter - Demo Guide

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK
- Android Studio / Xcode
- A physical device or emulator

### Installation

```bash
# Clone the repository (if applicable)
git clone <repository-url>
cd lms_mobile_flutter

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 👤 Demo Accounts

The app comes with pre-configured demo accounts for testing:

### Student Account
- **Email:** `student@demo.com`
- **Password:** `student123`
- **Name:** Nguyễn Văn An
- **Role:** Student

### Instructor Account
- **Email:** `instructor@demo.com`
- **Password:** `instructor123`
- **Name:** TS. Trần Thị Bình
- **Role:** Instructor

### Admin Account
- **Email:** `admin@demo.com`
- **Password:** `admin123`
- **Name:** Administrator
- **Role:** Admin

## ✨ Features Implemented

### 1. Chat System
- ✅ Real-time messaging with typing indicators
- ✅ Debounced typing detection (800ms)
- ✅ Last seen status per user
- ✅ File attachment support with preview
- ✅ File size display
- ✅ Animated typing dots indicator
- ✅ Socket.IO event definitions ready for backend integration

**Events Ready:**
- `chat:join`, `chat:leave`, `chat:send-message`
- `chat:message-received`, `chat:user-typing`, `chat:online-users`

### 2. Livestream (WebRTC)
- ✅ 1-to-N video streaming architecture
- ✅ Participants grid layout (auto-adjusts for 1, 2, or 4+ users)
- ✅ Video/Audio toggle controls
- ✅ Camera permission handling with user-friendly error messages
- ✅ WebRTC offer/answer/ICE candidate flow
- ✅ Mock participants for UI testing

**Events Ready:**
- `livestream:join`, `livestream:webrtc-offer`, `livestream:webrtc-answer`
- `livestream:ice-candidate`, `livestream:participant-joined/left`

### 3. Quiz System
- ✅ Multiple question types:
  - Multiple choice
  - True/False
  - Short answer
  - Essay (manual grading)
- ✅ Auto-grading for objective questions
- ✅ Timer per question
- ✅ Quiz attempts stored in Hive (local database)
- ✅ Statistics: average score, highest/lowest, completion rate
- ✅ Class-level statistics

**Events Ready:**
- `quiz:join`, `quiz:submit-answer`, `quiz:started`, `quiz:ended`

### 4. Notifications
- ✅ `flutter_local_notifications` integrated
- ✅ Android 13+ permission handling
- ✅ iOS notification configuration
- ✅ Notification priority levels (low/normal/high)
- ✅ Scheduled notifications support
- ✅ Socket-to-notification mapper utility
- ✅ Deep link payload support

**Events Ready:**
- `notification:new`, `notification:read`, `notification:bulk`

### 5. UX/Polish
- ✅ Shimmer loading skeletons for:
  - Course cards
  - List items
  - Generic content
- ✅ Empty state widgets with custom icons and actions
- ✅ Error state widgets with retry functionality
- ✅ Network error overlay (sticky banner)
- ✅ Loading overlay with optional message
- ✅ Consistent design system

### 6. Network & Connectivity
- ✅ `connectivity_plus` integration
- ✅ Real-time network status monitoring
- ✅ Timeout wrapper for API calls (30s default)
- ✅ Error message standardization
- ✅ Offline/online state management with Riverpod

### 7. Architecture & Code Quality
- ✅ Clean architecture with feature-based structure
- ✅ Riverpod for state management
- ✅ Hive for local persistence
- ✅ Socket.IO client ready for real-time features
- ✅ WebRTC client with Flutter WebRTC
- ✅ Centralized event definitions (`socket_events.dart`)
- ✅ Demo data utilities for testing

## 📁 Project Structure

```
lib/
├── core/
│   ├── config/          # App configuration
│   ├── data/            # Demo data & mock accounts
│   ├── network/         # Dio client, connectivity
│   ├── realtime/        # Socket.IO client & events
│   ├── storage/         # Shared preferences
│   ├── theme/           # App theming
│   ├── webrtc/          # WebRTC client
│   └── widgets/         # Reusable widgets (shimmer, empty states)
├── features/
│   ├── analytics/       # Learning analytics
│   ├── auth/            # Authentication
│   ├── chat/            # Chat system
│   ├── chatbot/         # AI chatbot
│   ├── courses/         # Course management
│   ├── files/           # File handling
│   ├── livestream/      # Video streaming
│   ├── notifications/   # Push notifications
│   ├── quiz/            # Quiz system
│   └── recommendations/ # Course recommendations
├── routes/              # Navigation
├── screens/             # UI screens
├── app.dart             # App widget
└── main.dart            # Entry point
```

## 🔧 Configuration

### Environment Variables

Run with custom configuration:

```bash
# Development mode with local backend
flutter run --dart-define=API_BASE_URL=http://localhost:3000/api --dart-define=SOCKET_URL=http://localhost:3003

# Demo mode (default)
flutter run --dart-define=DEMO_MODE=true
```

### Android Permissions

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

### iOS Permissions

Add to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access for video livestreaming</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access for audio in livestreaming</string>
```

## 🔌 Backend Integration Guide

### 1. Socket.IO Events

All events are defined in `lib/core/realtime/socket_events.dart`. To connect:

```dart
import 'package:lms_mobile_flutter/core/realtime/socket_client.dart';
import 'package:lms_mobile_flutter/core/realtime/socket_events.dart';

final socket = SocketClient(url: 'http://your-backend:3003');
socket.connect(auth: {'token': 'user-token'});

// Listen to events
socket.on(ChatEvents.messageReceived, (data) {
  final payload = ChatMessagePayload.fromJson(data);
  // Handle message
});

// Emit events
socket.emit(ChatEvents.sendMessage, ChatMessagePayload(...).toJson());
```

### 2. REST API

Update `lib/core/network/dio_client.dart` to add:
- Auth token interceptor
- Refresh token logic
- Error handling (401 redirect)

### 3. Secure Storage

Use `flutter_secure_storage` for sensitive data:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
await storage.write(key: 'auth_token', value: token);
final token = await storage.read(key: 'auth_token');
```

## 📱 Testing

### Test Scenarios

1. **Chat**
   - Login as student@demo.com
   - Navigate to any course → Chat tab
   - Type a message and observe typing indicator
   - Send message with/without attachment
   - Check last seen status

2. **Livestream**
   - Login as instructor@demo.com
   - Start a livestream from course detail
   - Toggle video/audio
   - Observe mock participants joining

3. **Quiz**
   - Login as student@demo.com
   - Start a quiz from course detail → Quiz tab
   - Answer different question types
   - View results and statistics

4. **Notifications**
   - Allow notification permissions on first launch
   - Trigger demo notifications (implement in UI)
   - Check notification history

## 🐛 Known Issues & TODO

- [ ] Implement actual Socket.IO connection (currently mock)
- [ ] Add real WebRTC signaling server
- [ ] Implement manual grading UI for essay questions
- [ ] Add file upload to server (currently local paths only)
- [ ] Implement notification deep linking
- [ ] Add CI/CD pipeline
- [ ] Write unit & integration tests
- [ ] Add analytics tracking
- [ ] Implement offline mode for courses
- [ ] Add accessibility labels for screen readers

## 📚 Additional Libraries to Consider

Based on the original requirements, you may want to add:

```yaml
dependencies:
  # Web & URLs
  url_launcher: ^6.3.0          # Open URLs, emails, phone calls
  webview_flutter: ^4.9.0       # In-app web browser
  
  # Device Info
  device_info_plus: ^10.1.0     # Device information
  
  # Animations
  flutter_animate: ^4.5.0       # Easy animations
  
  # Media
  just_audio: ^0.9.40           # Audio player
  
  # Downloads
  flutter_downloader: ^1.11.8   # File downloader
  
  # Authentication
  google_sign_in: ^6.2.1        # Google OAuth
  firebase_auth: ^5.3.3         # Firebase Auth
  
  # Push Notifications
  firebase_messaging: ^15.1.5   # FCM
  onesignal_flutter: ^5.2.7     # OneSignal
  
  # UI
  google_fonts: ^6.2.1          # Google Fonts
  flutter_easyloading: ^3.0.5   # Loading indicators
```

## 🎨 Screenshots

(Add screenshots here after testing)

## 📞 Support

For issues or questions, please contact the development team or create an issue in the repository.

---

**Last Updated:** October 2025  
**Version:** 0.1.0  
**Maintained by:** LMS Development Team
