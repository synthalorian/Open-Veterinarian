import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'pathology.g.dart';

@immutable
@HiveType(typeId: 10)
class Pathology extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String category; // e.g., Endocrine, Renal, Cardiac
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<String> clinicalSigns;
  @HiveField(4)
  final List<String> diagnosticSteps;
  @HiveField(5)
  final String managementSummary;

  Pathology({
    required this.name,
    required this.category,
    required this.description,
    required this.clinicalSigns,
    required this.diagnosticSteps,
    required this.managementSummary,
  });
}

final List<Pathology> initialPathologyData = [
  Pathology(
    name: 'Diabetes Mellitus',
    category: 'Endocrine',
    description: 'Relative or absolute insulin deficiency leading to persistent hyperglycemia.',
    clinicalSigns: ['Polyuria (PU)', 'Polydipsia (PD)', 'Polyphagia', 'Weight loss'],
    diagnosticSteps: ['Blood Glucose', 'Urinalysis (Glucosuria/Ketonuria)', 'Fructosamine'],
    managementSummary: 'Insulin therapy (Caninsulin/Lantus), high-protein low-carb diet (cats), weight management.',
  ),
  Pathology(
    name: 'Chronic Kidney Disease (CKD)',
    category: 'Renal',
    description: 'Progressive loss of kidney function over months to years.',
    clinicalSigns: ['PU/PD', 'Vomiting', 'Anorexia', 'Lethargy', 'Weight loss'],
    diagnosticSteps: ['Creatinine & SDMA', 'Urine Specific Gravity (USG < 1.035 in dogs, < 1.040 in cats)', 'Blood Pressure'],
    managementSummary: 'Renal prescription diet, hydration support, phosphate binders, blood pressure control.',
  ),
  Pathology(
    name: 'Congestive Heart Failure (CHF)',
    category: 'Cardiac',
    description: 'The hearts inability to pump blood effectively, leading to fluid congestion.',
    clinicalSigns: ['Coughing (dogs)', 'Increased Sleeping Respiratory Rate (SRR > 30)', 'Exercise intolerance', 'Dyspnea'],
    diagnosticSteps: ['Thoracic Radiographs', 'Echocardiography', 'NT-proBNP'],
    managementSummary: 'Furosemide (diuretic), Pimobendan (inodilator), ACE inhibitors (Enalapril/Benazepril).',
  ),
];
