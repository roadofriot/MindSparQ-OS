import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_typography.dart';

/// Stitch Pill Search Field for table headers and application navigation bar.
class AppSearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final double? width;
  final double height;

  const AppSearchField({
    super.key,
    this.hintText = 'खोज गर्नुहोस् (Search)...',
    this.controller,
    this.onChanged,
    this.onClear,
    this.width,
    this.height = 38.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTypography.bodyMd.copyWith(fontSize: 13),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.bodyMd.copyWith(
            color: AppColors.onSurfaceVariant.withAlpha(160),
            fontSize: 13,
          ),
          filled: true,
          fillColor: AppColors.surfaceContainerLow,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
          prefixIcon: const Icon(
            Icons.search,
            size: 18,
            color: AppColors.onSurfaceVariant,
          ),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () {
                    controller!.clear();
                    onClear?.call();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: AppRadii.roundedFull,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppRadii.roundedFull,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppRadii.roundedFull,
            borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
          ),
        ),
      ),
    );
  }
}
