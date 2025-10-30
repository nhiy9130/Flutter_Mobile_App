import 'package:flutter/material.dart';

/// Progress card widget for displaying course or learning progress
class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    this.color,
    this.onTap,
    this.trailing,
    this.icon,
    this.showPercentage = true,
    this.elevation = 0,
  });

  final String title;
  final String subtitle;
  final double progress; // 0.0 to 1.0
  final Color? color;
  final VoidCallback? onTap;
  final Widget? trailing;
  final IconData? icon;
  final bool showPercentage;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressColor = color ?? theme.colorScheme.primary;
    final percentage = (progress * 100).toInt();
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? theme.colorScheme.surface : theme.colorScheme.surface,
              isDark
                  ? theme.colorScheme.surface.withValues(alpha: 0.95)
                  : progressColor.withValues(alpha: 0.02),
            ],
          ),
          border: Border.all(
            color: progressColor.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Icon section
                    if (icon != null) ...[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: progressColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: progressColor, size: 24),
                      ),
                      const SizedBox(width: 12),
                    ],
                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_outlined,
                                size: 14,
                                color: theme.textTheme.bodySmall?.color
                                    ?.withValues(alpha: 0.6),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  subtitle,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.textTheme.bodySmall?.color
                                        ?.withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Trailing or percentage
                    if (trailing != null) ...[
                      const SizedBox(width: 12),
                      trailing!,
                    ] else if (showPercentage) ...[
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: progressColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$percentage%',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: progressColor,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                // Progress bar
                Stack(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: progressColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              progressColor,
                              progressColor.withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: progressColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Progress milestone indicator
                if (progress > 0 && progress < 1) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getProgressMessage(percentage),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: progressColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        '${100 - percentage}% còn lại',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(
                            alpha: 0.5,
                          ),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getProgressMessage(int percentage) {
    if (percentage >= 90) return '🎉 Sắp hoàn thành!';
    if (percentage >= 75) return '💪 Đang rất tốt!';
    if (percentage >= 50) return '📈 Đã quá nửa chặng!';
    if (percentage >= 25) return '🚀 Đang tiến bộ!';
    return '🌟 Bắt đầu thôi!';
  }
}
