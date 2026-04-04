import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'ecg_reference.g.dart';

@immutable
@HiveType(typeId: 13)
class EcgPattern extends HiveObject {
  @HiveField(0)
  final String rhythmName;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final List<String> characteristics;
  @HiveField(3)
  final String treatment;

  EcgPattern({
    required this.rhythmName,
    required this.description,
    required this.characteristics,
    required this.treatment,
  });
}

final List<EcgPattern> initialEcgData = [
  EcgPattern(
    rhythmName: 'Sinus Tachycardia',
    description: 'Normal sinus rhythm with a faster than normal rate.',
    characteristics: ['P-wave for every QRS', 'Regular R-R intervals', 'HR > 160 (dog), > 240 (cat)'],
    treatment: 'Identify underlying cause (Pain, stress, fever, hypovolemia).',
  ),
  EcgPattern(
    rhythmName: 'Ventricular Premature Complexes (VPC)',
    description: 'Ectopic beats originating from the ventricles.',
    characteristics: ['No P-wave before VPC', 'Wide and bizarre QRS', 'T-wave often opposite to QRS'],
    treatment: 'Lidocaine if frequent (>20/min) or R-on-T phenomenon.',
  ),
];
