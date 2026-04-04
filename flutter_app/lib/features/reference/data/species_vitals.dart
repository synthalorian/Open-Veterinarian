import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'species_vitals.g.dart';

@immutable
@HiveType(typeId: 0)
class VitalRange {
  @HiveField(0)
  final double min;
  @HiveField(1)
  final double max;
  @HiveField(2)
  final String unit;

  const VitalRange({required this.min, required this.max, required this.unit});

  @override
  String toString() => '$min - $max $unit';
}

@immutable
@HiveType(typeId: 1)
class SpeciesVitals extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String scientificName;
  @HiveField(2)
  final VitalRange temperature; // Celsius
  @HiveField(3)
  final VitalRange heartRate;    // BPM
  @HiveField(4)
  final VitalRange respiratoryRate; // BRPM

  SpeciesVitals({
    required this.name,
    required this.scientificName,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
  });
}

// Initial Data Seed
final List<SpeciesVitals> initialVitalsData = [
  SpeciesVitals(
    name: 'Canine',
    scientificName: 'Canis lupus familiaris',
    temperature: const VitalRange(min: 37.8, max: 39.2, unit: '°C'),
    heartRate: const VitalRange(min: 60, max: 140, unit: 'bpm'),
    respiratoryRate: const VitalRange(min: 10, max: 30, unit: 'brpm'),
  ),
  SpeciesVitals(
    name: 'Feline',
    scientificName: 'Felis catus',
    temperature: const VitalRange(min: 38.1, max: 39.2, unit: '°C'),
    heartRate: const VitalRange(min: 140, max: 220, unit: 'bpm'),
    respiratoryRate: const VitalRange(min: 20, max: 42, unit: 'brpm'),
  ),
  SpeciesVitals(
    name: 'Equine',
    scientificName: 'Equus ferus caballus',
    temperature: const VitalRange(min: 37.2, max: 38.3, unit: '°C'),
    heartRate: const VitalRange(min: 28, max: 44, unit: 'bpm'),
    respiratoryRate: const VitalRange(min: 8, max: 16, unit: 'brpm'),
  ),
  SpeciesVitals(
    name: 'Bovine',
    scientificName: 'Bos taurus',
    temperature: const VitalRange(min: 38.0, max: 39.3, unit: '°C'),
    heartRate: const VitalRange(min: 40, max: 80, unit: 'bpm'),
    respiratoryRate: const VitalRange(min: 12, max: 36, unit: 'brpm'),
  ),
  SpeciesVitals(
    name: 'Ovine',
    scientificName: 'Ovis aries',
    temperature: const VitalRange(min: 38.3, max: 39.9, unit: '°C'),
    heartRate: const VitalRange(min: 70, max: 90, unit: 'bpm'),
    respiratoryRate: const VitalRange(min: 12, max: 20, unit: 'brpm'),
  ),
  SpeciesVitals(
    name: 'Porcine',
    scientificName: 'Sus scrofa domesticus',
    temperature: const VitalRange(min: 38.7, max: 39.8, unit: '°C'),
    heartRate: const VitalRange(min: 60, max: 80, unit: 'bpm'),
    respiratoryRate: const VitalRange(min: 8, max: 18, unit: 'brpm'),
  ),
];
