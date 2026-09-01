import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_typography.dart';

class DropdownOption<T> {
  final T value;
  final String label;

  const DropdownOption({required this.value, required this.label});
}

/// Stitch Form Select/Dropdown Component
class AppDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final T? value;
  final List<DropdownOption<T>> options;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;

  const AppDropdown({
    super.key,
    this.label,
    this.hintText,
    required this.value,
    required this.options,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: AppTypography.labelMd.copyWith(color: AppColors.onSurface),
              ),
              if (isRequired) ...[
                const SizedBox(width: 4),
                Text(
                  '*',
                  style: AppTypography.labelMd.copyWith(color: AppColors.error),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: AppRadii.roundedLg,
            border: Border.all(color: AppColors.outlineVariant, width: 1.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              hint: hintText != null
                  ? Text(
                      hintText!,
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant.withAlpha(160),
                      ),
                    )
                  : null,
              icon: const Icon(
                Icons.expand_more,
                color: AppColors.onSurfaceVariant,
                size: 20,
              ),
              style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface),
              borderRadius: AppRadii.roundedLg,
              dropdownColor: AppColors.surfaceContainerLowest,
              items: options.map((opt) {
                return DropdownMenuItem<T>(
                  value: opt.value,
                  child: Text(opt.label),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
