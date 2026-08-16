import 'package:ballistic/shared/theme/app_colors.dart';
import 'package:ballistic/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class RecentWorkouts extends StatelessWidget {
  const RecentWorkouts({super.key});

  static const List<_WorkoutData> _workouts = <_WorkoutData>[
    _WorkoutData(
      title: 'Rhythm Shooting',
      detail: '24 shots • 18 min',
      date: 'Today',
      score: 91,
      change: '+3',
    ),
    _WorkoutData(
      title: 'Form Session',
      detail: '36 shots • 26 min',
      date: 'Thursday',
      score: 88,
      change: '+1',
    ),
    _WorkoutData(
      title: 'Game-Speed Reps',
      detail: '42 shots • 31 min',
      date: 'Tuesday',
      score: 86,
      change: '+2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Text('Recent workouts', style: AppTextStyles.sectionTitle),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View all',
                style: TextStyle(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 760) {
              return Row(
                children: _workouts
                    .map(
                      (_WorkoutData workout) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: workout == _workouts.last ? 0 : 14,
                          ),
                          child: _WorkoutCard(data: workout),
                        ),
                      ),
                    )
                    .toList(),
              );
            }

            return Column(
              children: _workouts
                  .map(
                    (_WorkoutData workout) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _WorkoutCard(data: workout),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.data});

  final _WorkoutData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.elevated,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.sports_basketball,
              color: AppColors.orange,
              size: 22,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${data.date} • ${data.detail}',
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${data.score}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                data.change,
                style: const TextStyle(
                  color: AppColors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorkoutData {
  const _WorkoutData({
    required this.title,
    required this.detail,
    required this.date,
    required this.score,
    required this.change,
  });

  final String title;
  final String detail;
  final String date;
  final int score;
  final String change;
}
