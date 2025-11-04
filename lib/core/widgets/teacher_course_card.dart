import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_dimensions.dart';
import 'custom_cards.dart';

/// Thẻ khóa học dành cho giảng viên (TeacherCourseCard)
/// Hiển thị: Thumbnail, Tiêu đề, và thông tin ngắn gọn (số học viên, thời lượng)
class TeacherCourseCard extends StatelessWidget {
  const TeacherCourseCard({
    super.key,
    required this.title,
    this.thumbnailUrl,
    required this.enrolledText,
    required this.durationText,
    this.onTap,
    this.trailing,
  });

  final String title;
  final String? thumbnailUrl;
  final String enrolledText; // ví dụ: "10,8k học viên"
  final String durationText; // ví dụ: "24 giờ"
  final VoidCallback? onTap;
  final Widget? trailing; // tuỳ chọn: menu "..." hay nút CTA

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.smMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildThumbnail(),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.h6.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(
                      Icons.people_alt_rounded,
                      size: AppSizes.iconSm,
                      color: AppColors.grey600,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Flexible(
                      child: Text(
                        enrolledText,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.grey700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Icon(
                      Icons.schedule_rounded,
                      size: AppSizes.iconSm,
                      color: AppColors.grey600,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Flexible(
                      child: Text(
                        durationText,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.grey700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    final borderRadius = BorderRadius.circular(AppRadius.md);

    Widget content;
    if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            thumbnailUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _placeholder(),
          ),
        ),
      );
    } else {
      content = ClipRRect(
        borderRadius: borderRadius,
        child: AspectRatio(aspectRatio: 16 / 9, child: _placeholder()),
      );
    }

    return SizedBox(width: 120, child: content);
  }

  Widget _placeholder() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.school_rounded,
        color: AppColors.white.withValues(alpha: 0.9),
        size: AppSizes.iconXl2,
      ),
    );
  }
}
