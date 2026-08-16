import 'package:ballistic/shared/theme/app_colors.dart';
import 'package:ballistic/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AnalyzeWorkoutCard extends StatelessWidget {
  const AnalyzeWorkoutCard({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('analyze-workout-card'),
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0x28FF6B00),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.video_camera_back_rounded,
              color: AppColors.orange,
            ),
          ),
          const SizedBox(height: 18),
          const Text('Analyze a workout', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 7),
          const Text(
            'Upload your shooting video and get mechanics, trends, and a clear coaching focus.',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              key: const Key('analyze-workout-button'),
              onPressed: onPressed,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Analyze Workout'),
            ),
          ),
        ],
      ),
    );
  }
}
