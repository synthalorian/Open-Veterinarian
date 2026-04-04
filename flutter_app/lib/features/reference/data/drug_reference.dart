import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'drug_reference.g.dart';

@immutable
@HiveType(typeId: 2)
class Dosage {
  @HiveField(0)
  final double min;
  @HiveField(1)
  final double max;
  @HiveField(2)
  final String unit; // e.g., mg/kg
  @HiveField(3)
  final String frequency; // e.g., q12h, q24h
  @HiveField(4)
  final String route; // e.g., IV, IM, PO

  const Dosage({
    required this.min,
    required this.max,
    required this.unit,
    this.frequency = 'N/A',
    this.route = 'N/A',
  });

  @override
  String toString() => '$min-$max $unit ($route, $frequency)';
}

@immutable
@HiveType(typeId: 3)
class DrugReference extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String category; // e.g., Antibiotic, Analgesic
  @HiveField(2)
  final String description;
  @HiveField(3)
  final Map<String, Dosage> speciesDosages; // key: 'canine', 'feline', etc.

  DrugReference({
    required this.name,
    required this.category,
    required this.description,
    required this.speciesDosages,
  });
}

// Initial Drug Seeds
final List<DrugReference> initialDrugData = [
  DrugReference(
    name: 'Meloxicam',
    category: 'NSAID / Analgesic',
    description: 'Relief of inflammation and pain in both acute and chronic musculo-skeletal disorders.',
    speciesDosages: {
      'canine': const Dosage(min: 0.1, max: 0.2, unit: 'mg/kg', route: 'PO/SC', frequency: 'q24h'),
      'feline': const Dosage(min: 0.05, max: 0.1, unit: 'mg/kg', route: 'PO/SC', frequency: 'q24h'),
    },
  ),
  DrugReference(
    name: 'Amoxicillin/Clavulanate',
    category: 'Antibiotic',
    description: 'Broad-spectrum bactericidal activity against common pathogens.',
    speciesDosages: {
      'canine': const Dosage(min: 12.5, max: 25.0, unit: 'mg/kg', route: 'PO', frequency: 'q12h'),
      'feline': const Dosage(min: 12.5, max: 20.0, unit: 'mg/kg', route: 'PO', frequency: 'q12h'),
    },
  ),
  DrugReference(
    name: 'Propofol',
    category: 'Induction Agent',
    description: 'Ultra-short-acting hypnotic for induction of general anesthesia.',
    speciesDosages: {
      'canine': const Dosage(min: 4.0, max: 6.0, unit: 'mg/kg', route: 'IV', frequency: 'Induction'),
      'feline': const Dosage(min: 4.0, max: 8.0, unit: 'mg/kg', route: 'IV', frequency: 'Induction'),
    },
  ),
  DrugReference(
    name: 'Gabapentin',
    category: 'Analgesic / Anticonvulsant',
    description: 'Adjunctive treatment of neuropathic pain and refractory seizures.',
    speciesDosages: {
      'canine': const Dosage(min: 5.0, max: 10.0, unit: 'mg/kg', route: 'PO', frequency: 'q8h-q12h'),
      'feline': const Dosage(min: 5.0, max: 10.0, unit: 'mg/kg', route: 'PO', frequency: 'q8h-q12h'),
    },
  ),
  DrugReference(
    name: 'Maropitant (Cerenia)',
    category: 'Antiemetic',
    description: 'Treatment and prevention of acute vomiting and motion sickness.',
    speciesDosages: {
      'canine': const Dosage(min: 1.0, max: 2.0, unit: 'mg/kg', route: 'SC/PO', frequency: 'q24h'),
      'feline': const Dosage(min: 1.0, max: 1.0, unit: 'mg/kg', route: 'SC/IV', frequency: 'q24h'),
    },
  ),
  DrugReference(
    name: 'Buprenorphine',
    category: 'Opioid Analgesic',
    description: 'Potent analgesic for moderate to severe pain relief.',
    speciesDosages: {
      'canine': const Dosage(min: 0.01, max: 0.02, unit: 'mg/kg', route: 'IV/IM/SC', frequency: 'q6h-q12h'),
      'feline': const Dosage(min: 0.01, max: 0.03, unit: 'mg/kg', route: 'IV/IM/OTM', frequency: 'q6h-q12h'),
    },
  ),
  DrugReference(
    name: 'Enrofloxacin (Baytril)',
    category: 'Fluoroquinolone Antibiotic',
    description: 'Broad-spectrum antibiotic used to treat bacterial infections.',
    speciesDosages: {
      'canine': const Dosage(min: 5.0, max: 20.0, unit: 'mg/kg', route: 'PO/SC', frequency: 'q24h'),
      'feline': const Dosage(min: 5.0, max: 5.0, unit: 'mg/kg', route: 'PO/SC', frequency: 'q24h'),
    },
  ),
  DrugReference(
    name: 'Atropine',
    category: 'Anticholinergic',
    description: 'Preanesthetic to reduce secretions or treat bradycardia.',
    speciesDosages: {
      'canine': const Dosage(min: 0.02, max: 0.04, unit: 'mg/kg', route: 'IV/IM/SC', frequency: 'PRN'),
      'feline': const Dosage(min: 0.02, max: 0.04, unit: 'mg/kg', route: 'IV/IM/SC', frequency: 'PRN'),
    },
  ),
];
