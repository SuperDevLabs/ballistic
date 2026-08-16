import 'package:ballistic/features/analyze/domain/selected_video.dart';
import 'package:ballistic/shared/theme/app_colors.dart';
import 'package:ballistic/shared/theme/app_text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnalyzeScreen extends StatefulWidget {
  const AnalyzeScreen({this.initialVideo, super.key});

  final SelectedVideo? initialVideo;

  @override
  State<AnalyzeScreen> createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  SelectedVideo? _selectedVideo;
  bool _isChoosingFile = false;

  @override
  void initState() {
    super.initState();
    _selectedVideo = widget.initialVideo;
  }

  Future<void> _chooseVideo() async {
    if (_isChoosingFile) return;

    setState(() => _isChoosingFile = true);
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const <String>['mp4', 'mov', 'm4v', 'avi'],
        allowMultiple: false,
        withData: false,
      );
      if (!mounted || result == null || result.files.isEmpty) return;

      final PlatformFile file = result.files.single;
      setState(() {
        _selectedVideo = SelectedVideo(
          name: file.name,
          path: file.path,
          sizeBytes: file.size,
        );
      });
    } finally {
      if (mounted) setState(() => _isChoosingFile = false);
    }
  }

  void _startAnalysis() {
    final SelectedVideo? video = _selectedVideo;
    if (video != null) context.push('/processing', extra: video);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.courtBlack,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'ANALYZE WORKOUT',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.75, -0.85),
            radius: 1.2,
            colors: <Color>[Color(0x20FF6B00), AppColors.arenaBlack],
          ),
        ),
        child: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool wide = constraints.maxWidth >= 900;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: wide ? 40 : 20,
                  vertical: 30,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1080),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Turn your workout into a game plan.',
                          style: AppTextStyles.hero,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Choose a clear, full-body shooting video. BALLISTIC will find each shot and measure the mechanics you can improve.',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: 30),
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: _VideoPickerCard(
                                  video: _selectedVideo,
                                  isChoosingFile: _isChoosingFile,
                                  onChoose: _chooseVideo,
                                  onClear: _clearVideo,
                                ),
                              ),
                              const SizedBox(width: 22),
                              const Expanded(
                                flex: 4,
                                child: _RecordingGuideCard(),
                              ),
                            ],
                          )
                        else ...<Widget>[
                          _VideoPickerCard(
                            video: _selectedVideo,
                            isChoosingFile: _isChoosingFile,
                            onChoose: _chooseVideo,
                            onClear: _clearVideo,
                          ),
                          const SizedBox(height: 18),
                          const _RecordingGuideCard(),
                        ],
                        const SizedBox(height: 22),
                        const _AnalysisDetailsCard(),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            key: const Key('start-analysis-button'),
                            onPressed: _selectedVideo == null
                                ? null
                                : _startAnalysis,
                            icon: const Icon(Icons.auto_graph_rounded),
                            label: Text(
                              _selectedVideo == null
                                  ? 'Choose a video to continue'
                                  : 'Start Analysis',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _clearVideo() => setState(() => _selectedVideo = null);
}

class _VideoPickerCard extends StatelessWidget {
  const _VideoPickerCard({
    required this.video,
    required this.isChoosingFile,
    required this.onChoose,
    required this.onClear,
  });

  final SelectedVideo? video;
  final bool isChoosingFile;
  final VoidCallback onChoose;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: const Key('video-picker-card'),
      duration: const Duration(milliseconds: 220),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 330),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: video == null ? AppColors.line : AppColors.orange,
          width: video == null ? 1 : 1.4,
        ),
      ),
      child: video == null
          ? _EmptyVideoPicker(
              isChoosingFile: isChoosingFile,
              onChoose: onChoose,
            )
          : _SelectedVideoView(
              video: video!,
              onChoose: onChoose,
              onClear: onClear,
            ),
    );
  }
}

class _EmptyVideoPicker extends StatelessWidget {
  const _EmptyVideoPicker({
    required this.isChoosingFile,
    required this.onChoose,
  });

  final bool isChoosingFile;
  final VoidCallback onChoose;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: const Color(0x28FF6B00),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.video_library_outlined,
            color: AppColors.orange,
            size: 36,
          ),
        ),
        const SizedBox(height: 20),
        const Text('Choose a workout video', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 8),
        const Text('MP4, MOV, M4V, or AVI', style: AppTextStyles.body),
        const SizedBox(height: 22),
        OutlinedButton.icon(
          key: const Key('choose-video-button'),
          onPressed: isChoosingFile ? null : onChoose,
          icon: isChoosingFile
              ? const SizedBox.square(
                  dimension: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.folder_open_rounded),
          label: Text(isChoosingFile ? 'Opening files…' : 'Choose Video'),
        ),
      ],
    );
  }
}

class _SelectedVideoView extends StatelessWidget {
  const _SelectedVideoView({
    required this.video,
    required this.onChoose,
    required this.onClear,
  });

  final SelectedVideo video;
  final VoidCallback onChoose;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 160,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[AppColors.elevated, AppColors.courtBlack],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const Icon(
              Icons.play_circle_fill_rounded,
              color: AppColors.orange,
              size: 58,
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            const Icon(Icons.check_circle, color: AppColors.green, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    video.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(video.formattedSize, style: AppTextStyles.body),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Remove video',
              onPressed: onClear,
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
        TextButton(
          onPressed: onChoose,
          child: const Text('Choose a different video'),
        ),
      ],
    );
  }
}

class _RecordingGuideCard extends StatelessWidget {
  const _RecordingGuideCard();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('GET THE BEST RESULTS', style: AppTextStyles.label),
          SizedBox(height: 18),
          _GuideItem(
            icon: Icons.phone_iphone_rounded,
            title: 'Keep the phone steady',
            detail: 'Use a tripod or stable surface.',
          ),
          SizedBox(height: 16),
          _GuideItem(
            icon: Icons.accessibility_new_rounded,
            title: 'Show your full body',
            detail: 'Keep your feet, hands, and release visible.',
          ),
          SizedBox(height: 16),
          _GuideItem(
            icon: Icons.light_mode_outlined,
            title: 'Use clear lighting',
            detail: 'Avoid strong shadows and backlighting.',
          ),
          SizedBox(height: 16),
          _GuideItem(
            icon: Icons.landscape_outlined,
            title: 'Record from the side',
            detail: 'A slight side angle captures your mechanics.',
          ),
        ],
      ),
    );
  }
}

class _GuideItem extends StatelessWidget {
  const _GuideItem({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: AppColors.orange, size: 21),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(detail, style: AppTextStyles.body),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnalysisDetailsCard extends StatelessWidget {
  const _AnalysisDetailsCard();

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
      child: const Wrap(
        spacing: 28,
        runSpacing: 18,
        children: <Widget>[
          _AnalysisDetail(
            icon: Icons.bolt_rounded,
            label: 'Analysis',
            value: 'Jump shot',
          ),
          _AnalysisDetail(
            icon: Icons.speed_rounded,
            label: 'Mode',
            value: 'Full workout',
          ),
          _AnalysisDetail(
            icon: Icons.verified_outlined,
            label: 'Priority',
            value: 'Accuracy',
          ),
        ],
      ),
    );
  }
}

class _AnalysisDetail extends StatelessWidget {
  const _AnalysisDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Row(
        children: <Widget>[
          Icon(icon, color: AppColors.orange, size: 20),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label,
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
