import 'package:ballistic/features/analyze/domain/selected_video.dart';
import 'package:ballistic/shared/theme/app_colors.dart';
import 'package:ballistic/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProcessingScreen extends StatelessWidget {
  const ProcessingScreen({required this.video, super.key});

  final SelectedVideo? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.1,
            colors: <Color>[Color(0x30FF6B00), AppColors.arenaBlack],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        color: const Color(0x28FF6B00),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        Icons.sports_basketball,
                        color: AppColors.orange,
                        size: 43,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Preparing your analysis',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.hero,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      video?.name ?? 'Workout video',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: 30),
                    const LinearProgressIndicator(
                      value: 0.18,
                      minHeight: 7,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.orange,
                      backgroundColor: AppColors.line,
                    ),
                    const SizedBox(height: 28),
                    const _ProcessingSteps(),
                    const SizedBox(height: 26),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.charcoal,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.line),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.blue,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'The upload flow is ready. Connecting this screen to the Python analysis engine is the next milestone.',
                              style: AppTextStyles.body,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.home_outlined),
                      label: const Text('Return Home'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProcessingSteps extends StatelessWidget {
  const _ProcessingSteps();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line),
      ),
      child: const Column(
        children: <Widget>[
          _ProcessingStep(
            label: 'Video selected',
            icon: Icons.check_circle_rounded,
            color: AppColors.green,
          ),
          _StepLine(),
          _ProcessingStep(
            label: 'Preparing secure upload',
            icon: Icons.sync_rounded,
            color: AppColors.orange,
          ),
          _StepLine(),
          _ProcessingStep(
            label: 'Detecting shot attempts',
            icon: Icons.radio_button_unchecked,
            color: AppColors.subdued,
          ),
          _StepLine(),
          _ProcessingStep(
            label: 'Scoring mechanics',
            icon: Icons.radio_button_unchecked,
            color: AppColors.subdued,
          ),
        ],
      ),
    );
  }
}

class _ProcessingStep extends StatelessWidget {
  const _ProcessingStep({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 14),
        Text(
          label,
          style: TextStyle(
            color: color == AppColors.subdued
                ? AppColors.muted
                : AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: SizedBox(
          height: 22,
          child: VerticalDivider(color: AppColors.line),
        ),
      ),
    );
  }
}
