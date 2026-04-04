import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'triage.g.dart';

@immutable
@HiveType(typeId: 20)
class TriageCriteria extends HiveObject {
  @HiveField(0)
  final String category; // A, B, C, D, E
  @HiveField(1)
  final String description;
  @HiveField(2)
  final List<String> indicators;
  @HiveField(3)
  final String urgency; // Critical, Urgent, Stable

  TriageCriteria({
    required this.category,
    required this.description,
    required this.indicators,
    required this.urgency,
  });
}

final List<TriageCriteria> initialTriageData = [
  TriageCriteria(
    category: 'A - Airway',
    description: 'Assess patency of the upper airway.',
    indicators: ['Stridor', 'Stertor', 'Choking', 'Foreign body'],
    urgency: 'Critical',
  ),
  TriageCriteria(
    category: 'B - Breathing',
    description: 'Assess respiratory effort and character.',
    indicators: ['Dyspnea', 'Cyanosis', 'Open-mouth breathing (cats)', 'Tachypnea'],
    urgency: 'Critical',
  ),
  TriageCriteria(
    category: 'C - Circulation',
    description: 'Assess perfusion and cardiovascular status.',
    indicators: ['Pale/Grey MM', 'CRT > 2s', 'Weak pulses', 'Tachycardia/Bradycardia'],
    urgency: 'Critical',
  ),
  TriageCriteria(
    category: 'D - Disability',
    description: 'Assess neurological status.',
    indicators: ['Seizures', 'Altered mentation', 'Paresis/Paralysis', 'Anisocoria'],
    urgency: 'Urgent',
  ),
  TriageCriteria(
    category: 'E - External / Everything Else',
    description: 'Complete physical scan and other issues.',
    indicators: ['Hemorrhage', 'Fractures', 'Toxins', 'Abdominal pain'],
    urgency: 'Urgent/Stable',
  ),
];
