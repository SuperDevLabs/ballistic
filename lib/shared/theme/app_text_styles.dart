import 'package:ballistic/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  static const TextStyle brand = TextStyle(
    color: AppColors.white,
    fontSize: 19,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.6,
  );

  static const TextStyle hero = TextStyle(
    color: AppColors.white,
    fontSize: 34,
    height: 1.05,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.2,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: AppColors.white,
    fontSize: 19,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );

  static const TextStyle body = TextStyle(
    color: AppColors.muted,
    fontSize: 14,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle label = TextStyle(
    color: AppColors.muted,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.7,
  );
}
