import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'ophthalmology.g.dart';

@immutable
@HiveType(typeId: 15)
class OphthalmicReference extends HiveObject {
  @HiveField(0)
  final String condition;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String tonometerRange; // Normal IOP ranges
  @HiveField(3)
  final List<String> commonTreatments;

  OphthalmicReference({
    required this.condition,
    required this.description,
    required this.tonometerRange,
    required this.commonTreatments,
  });
}

final List<OphthalmicReference> initialOphthalmicData = [
  OphthalmicReference(
    condition: 'Glaucoma',
    description: 'Increased intraocular pressure (IOP) causing damage to the optic nerve and retina.',
    tonometerRange: 'Normal: 15-25 mmHg | Glaucoma: > 30 mmHg',
    commonTreatments: ['Latanoprost', 'Dorzolamide', 'Timolol', 'IV Mannitol (Emergency)'],
  ),
  OphthalmicReference(
    condition: 'Corneal Ulcer',
    description: 'Loss of the corneal epithelium, often detected via fluorescein staining.',
    tonometerRange: 'Usually normal (15-25 mmHg)',
    commonTreatments: ['Topical Antibiotics', 'Atropine (for pain/cycloplegia)', 'Serum (for melting ulcers)'],
  ),
];
