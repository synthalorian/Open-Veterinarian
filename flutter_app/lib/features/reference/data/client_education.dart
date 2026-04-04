import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'client_education.g.dart';

@immutable
@HiveType(typeId: 17)
class AnatomyDiagram extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String svgPath;
  @HiveField(2)
  final String explanation;

  AnatomyDiagram({
    required this.title,
    required this.svgPath,
    required this.explanation,
  });
}

final List<AnatomyDiagram> initialAnatomyDiagrams = [
  AnatomyDiagram(
    title: 'Canine Skeleton (Lateral)',
    svgPath: 'assets/images/canine_skeleton.svg',
    explanation: 'Basic skeletal structure highlighting the vertebral column and major joints (Shoulder, Elbow, Hip, Stifle).',
  ),
  AnatomyDiagram(
    title: 'Feline Internal Organs',
    svgPath: 'assets/images/feline_anatomy.svg',
    explanation: 'Placement of the heart, lungs, liver, kidneys, and gastrointestinal tract.',
  ),
];
