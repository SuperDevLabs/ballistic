import 'package:ballistic/features/home/presentation/widgets/analyze_workout_card.dart';
import 'package:ballistic/features/home/presentation/widgets/ballistic_score_card.dart';
import 'package:ballistic/features/home/presentation/widgets/recent_workouts.dart';
import 'package:ballistic/shared/theme/app_colors.dart';
import 'package:ballistic/shared/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.75, -0.85),
            radius: 1.1,
            colors: <Color>[Color(0x2AFF6B00), AppColors.arenaBlack],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              const _DashboardHeader(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool wide = constraints.maxWidth >= 920;
                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        wide ? 40 : 20,
                        30,
                        wide ? 40 : 20,
                        34,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1180),
                          child: wide
                              ? const _WideDashboard()
                              : const _CompactDashboard(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.orange),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights_rounded, color: AppColors.orange),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_basketball_outlined),
            selectedIcon: Icon(
              Icons.sports_basketball,
              color: AppColors.orange,
            ),
            label: 'Train',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person, color: AppColors.orange),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _WideDashboard extends StatelessWidget {
  const _WideDashboard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _WelcomeBlock(),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Expanded(flex: 6, child: BallisticScoreCard()),
            const SizedBox(width: 22),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  AnalyzeWorkoutCard(onPressed: () => context.push('/analyze')),
                  const SizedBox(height: 22),
                  const _WeeklyFocusCard(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 34),
        const RecentWorkouts(),
      ],
    );
  }
}

class _CompactDashboard extends StatelessWidget {
  const _CompactDashboard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _WelcomeBlock(),
        const SizedBox(height: 26),
        const BallisticScoreCard(),
        const SizedBox(height: 18),
        AnalyzeWorkoutCard(onPressed: () => context.push('/analyze')),
        const SizedBox(height: 18),
        const _WeeklyFocusCard(),
        const SizedBox(height: 30),
        const RecentWorkouts(),
      ],
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: const BoxDecoration(
        color: Color(0xD90E1319),
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.sports_basketball,
              color: Colors.white,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          const Text('BALLISTIC', style: AppTextStyles.brand),
          const Spacer(),
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.elevated,
            child: Text(
              'JS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeBlock extends StatelessWidget {
  const _WelcomeBlock();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('GOOD EVENING, JUSTIN', style: AppTextStyles.label),
        SizedBox(height: 8),
        Text('Ready to get better?', style: AppTextStyles.hero),
        SizedBox(height: 10),
        Text(
          'Every workout is another chance to raise your game.',
          style: AppTextStyles.body,
        ),
      ],
    );
  }
}

class _WeeklyFocusCard extends StatelessWidget {
  const _WeeklyFocusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.line),
      ),
      child: const Row(
        children: <Widget>[
          _FocusIcon(),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('THIS WEEK’S FOCUS', style: AppTextStyles.label),
                SizedBox(height: 7),
                Text(
                  'Repeatable shooting rhythm',
                  style: AppTextStyles.sectionTitle,
                ),
                SizedBox(height: 5),
                Text('3 of 5 workouts complete', style: AppTextStyles.body),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.muted),
        ],
      ),
    );
  }
}

class _FocusIcon extends StatelessWidget {
  const _FocusIcon();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x2632D583),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const SizedBox(
        width: 48,
        height: 48,
        child: Icon(Icons.track_changes_rounded, color: AppColors.green),
      ),
    );
  }
}
