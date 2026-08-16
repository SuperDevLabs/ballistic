import 'dart:math' as math;

import 'package:ballistic/shared/theme/app_colors.dart';
import 'package:ballistic/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class BallisticScoreCard extends StatelessWidget {
  const BallisticScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('ballistic-score-card'),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF202934), AppColors.charcoal],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x48FF6B00)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'BALLISTIC SCORE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x2632D583),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      '↑ 4 THIS MONTH',
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Center(child: _ScoreGauge(score: 91)),
          const SizedBox(height: 18),
          const Row(
            children: <Widget>[
              Expanded(
                child: _Metric(label: 'Release', value: '94'),
              ),
              _MetricDivider(),
              Expanded(
                child: _Metric(label: 'Rhythm', value: '87'),
              ),
              _MetricDivider(),
              Expanded(
                child: _Metric(label: 'Balance', value: '92'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreGauge extends StatelessWidget {
  const _ScoreGauge({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 170,
      child: CustomPaint(
        painter: _ScoreGaugePainter(progress: score / 100),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$score',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 54,
                  height: 0.95,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2.2,
                ),
              ),
              const SizedBox(height: 7),
              const Text('ELITE', style: AppTextStyles.label),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreGaugePainter extends CustomPainter {
  const _ScoreGaugePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 11;
    final Rect rect = Offset.zero & size;
    final Rect arcRect = rect.deflate(strokeWidth / 2);
    const double start = math.pi * 0.75;
    const double sweep = math.pi * 1.5;
    final Paint track = Paint()
      ..color = AppColors.line
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final Paint active = Paint()
      ..shader = const SweepGradient(
        colors: <Color>[AppColors.orange, AppColors.orangeLight],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(arcRect, start, sweep, false, track);
    canvas.drawArc(arcRect, start, sweep * progress, false, active);
  }

  @override
  bool shouldRepaint(_ScoreGaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.body),
      ],
    );
  }
}

class _MetricDivider extends StatelessWidget {
  const _MetricDivider();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 34,
      child: VerticalDivider(color: AppColors.line, thickness: 1),
    );
  }
}
