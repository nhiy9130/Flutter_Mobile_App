import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    super.key,
    required super.child,
    required this.apiBaseUrl,
    required this.socketUrl,
    required this.demoMode,
    this.requestTimeoutMs = 10000,
  });

  final String apiBaseUrl;
  final String socketUrl;
  final bool demoMode;
  final int requestTimeoutMs;

  static AppConfig of(BuildContext context) {
    final config = context.dependOnInheritedWidgetOfExactType<AppConfig>();
    assert(config != null, 'AppConfig not found in widget tree');
    return config!;
  }

  @override
  bool updateShouldNotify(covariant AppConfig oldWidget) {
    return apiBaseUrl != oldWidget.apiBaseUrl ||
        socketUrl != oldWidget.socketUrl ||
        demoMode != oldWidget.demoMode ||
        requestTimeoutMs != oldWidget.requestTimeoutMs;
  }
}
