import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'video_reference.dart';
import '../ui/glow_card.dart';

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
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl));
    await _videoPlayerController.initialize();
    
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.cyanAccent,
        handleColor: Colors.cyanAccent,
        backgroundColor: Colors.white10,
        bufferedColor: Colors.white24,
      ),
      placeholder: Container(
        color: Colors.black,
        child: const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
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
                  : const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.video.category.toUpperCase(),
                    style: const TextStyle(fontSize: 14, color: Colors.cyanAccent, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 16),
                  const Text('DESCRIPTION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.5)),
                  const SizedBox(height: 8),
                  Text(
                    widget.video.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
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
              glowColor: Colors.pinkAccent,
              child: ListTile(
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => VideoReferenceView(video: video))
                ),
                leading: const Icon(Icons.play_circle_fill, color: Colors.pinkAccent, size: 32),
                title: Text(video.title.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: Text(video.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right, color: Colors.pinkAccent),
              ),
            ),
          );
        },
      ),
    );
  }
}
