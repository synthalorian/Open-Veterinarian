import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'imaging.g.dart';

@immutable
@HiveType(typeId: 11)
class ImagingReference extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String category; // X-Ray, Ultrasound, CT
  @HiveField(2)
  final String positioning;
  @HiveField(3)
  final List<String> checklist;
  @HiveField(4)
  final String clinicalNotes;

  ImagingReference({
    required this.title,
    required this.category,
    required this.positioning,
    required this.checklist,
    required this.clinicalNotes,
  });
}

final List<ImagingReference> initialImagingData = [
  ImagingReference(
    title: 'Thoracic - Lat & VD',
    category: 'X-Ray',
    positioning: 'Right Lateral and Ventrodorsal (VD).',
    checklist: [
      'Collimate from thoracic inlet to last rib.',
      'Peak inspiration for VD view.',
      'Front legs pulled cranially.',
    ],
    clinicalNotes: 'Evaluate heart size (VHS), lung patterns, and pleural space.',
  ),
  ImagingReference(
    title: 'Abdominal - Lat & VD',
    category: 'X-Ray',
    positioning: 'Right Lateral and Ventrodorsal.',
    checklist: [
      'Collimate from T9 to greater trochanter.',
      'Peak expiration.',
      'Hind legs pulled caudally.',
    ],
    clinicalNotes: 'Assess organ margins, gas patterns, and potential foreign bodies.',
  ),
  ImagingReference(
    title: 'AFAST / TFAST',
    category: 'Ultrasound',
    positioning: 'Lateral or Sternal recumbency.',
    checklist: [
      'Diaphragmatico-hepatic (DH) view.',
      'Spleno-renal (SR) view.',
      'Cysto-colic (CC) view.',
      'Hepato-renal (HR) view.',
    ],
    clinicalNotes: 'Rapid assessment for free fluid (effusion) or pneumothorax.',
  ),
];
