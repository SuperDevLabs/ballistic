class SelectedVideo {
  const SelectedVideo({
    required this.name,
    required this.path,
    required this.sizeBytes,
  });

  final String name;
  final String? path;
  final int sizeBytes;

  String get formattedSize {
    if (sizeBytes < 1024) {
      return '$sizeBytes B';
    }
    if (sizeBytes < 1024 * 1024) {
      return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
