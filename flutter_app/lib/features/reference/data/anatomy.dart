import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'anatomy.g.dart';

@immutable
@HiveType(typeId: 12)
class AnatomyReference extends HiveObject {
  @HiveField(0)
  final String partName;
  @HiveField(1)
  final String system; // Skeletal, Muscular, Nervous, etc.
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<String> clinicalSignificance;

  AnatomyReference({
    required this.partName,
    required this.system,
    required this.description,
    required this.clinicalSignificance,
  });
}

final List<AnatomyReference> initialAnatomyData = [
  AnatomyReference(
    partName: 'Cervical Vertebrae',
    system: 'Skeletal',
    description: 'Seven vertebrae (C1-C7) in the neck. C1 is the Atlas, C2 is the Axis.',
    clinicalSignificance: ['IVDD (Intervertebral Disc Disease)', 'Wobbler Syndrome', 'Atlantoaxial Subluxation'],
  ),
  AnatomyReference(
    partName: 'Cranial Cruciate Ligament (CCL)',
    system: 'Stifle / Joint',
    description: 'Connects the femur to the tibia, preventing cranial displacement of the tibia.',
    clinicalSignificance: ['CCL Rupture (Drawer sign)', 'Osteoarthritis', 'Tibial Plateau Leveling Osteotomy (TPLO)'],
  ),
];
