import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'video_reference.dart';
import '../ui/glow_card.dart';
import 'package:open_veterinarian/features/theme/app_theme.dart';

class VideoReferenceView extends StatefulWidget {
  final VideoReference video;

  const VideoReferenceView({super.key, required this.video});

  @override
  State<VideoReferenceView> createState() => _VideoReferenceViewState();
}

class _VideoReferenceViewState extends State<VideoReferenceView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    final appColors = Theme.of(context).extension<AppColors>()!;
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl));
    await _videoPlayerController.initialize();
    
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      materialProgressColors: ChewieProgressColors(
        playedColor: appColors.accent,
        handleColor: appColors.accent,
        backgroundColor: appColors.accent.withAlpha(26),
        bufferedColor: appColors.accent.withAlpha(61),
      ),
      placeholder: Container(
        color: appColors.surface,
        child: Center(child: CircularProgressIndicator(color: appColors.accent)),
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                  ? Chewie(controller: _chewieController!)
                  : Center(child: CircularProgressIndicator(color: appColors.accent)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: appColors.accent),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.video.category.toUpperCase(),
                    style: TextStyle(fontSize: 14, color: appColors.accent, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 16),
                  Text('DESCRIPTION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: appColors.sectionHeader, letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  Text(
                    widget.video.description,
                    style: TextStyle(fontSize: 16, color: appColors.textDim, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoLibraryView extends StatelessWidget {
  const VideoLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final videos = initialVideoData; // Mock data for now

    return Scaffold(
      appBar: AppBar(title: const Text('VIDEO REFERENCE LIBRARY')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlowCard(
              glowColor: appColors.accentTertiary,
              child: ListTile(
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => VideoReferenceView(video: video))
                ),
                leading: Icon(Icons.play_circle_fill, color: appColors.accentTertiary, size: 32),
                title: Text(video.title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: appColors.accent)),
                subtitle: Text(video.category, style: TextStyle(fontSize: 12, color: appColors.textDim)),
                trailing: Icon(Icons.chevron_right, color: appColors.accentTertiary),
              ),
            ),
          );
        },
      ),
    );
  }
}