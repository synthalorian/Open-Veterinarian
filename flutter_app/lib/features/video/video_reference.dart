import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'video_reference.g.dart';

@immutable
@HiveType(typeId: 19)
class VideoReference extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String category; // e.g., "Surgical", "Diagnostic", "Handling"
  @HiveField(2)
  final String videoUrl; // URL or local asset path
  @HiveField(3)
  final String description;

  VideoReference({
    required this.title,
    required this.category,
    required this.videoUrl,
    required this.description,
  });
}

final List<VideoReference> initialVideoData = [
  VideoReference(
    title: 'IV Catheter Placement',
    category: 'Diagnostic',
    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', // Placeholder URL
    description: 'Techniques for cephalic and saphenous IV catheterization in canines and felines.',
  ),
  VideoReference(
    title: 'Surgical Scrub Technique',
    category: 'Surgical',
    videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4', // Placeholder URL
    description: 'Proper aseptic preparation of the surgical site and hands.',
  ),
];
