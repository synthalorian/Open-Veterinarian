import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'anesthesia_protocols.g.dart';

@immutable
@HiveType(typeId: 9)
class AnesthesiaProtocol extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final Map<String, String> drugs; // e.g., {'Pre-med': 'Acepromazine + Morphine'}
  @HiveField(3)
  final String indications;

  AnesthesiaProtocol({
    required this.name,
    required this.description,
    required this.drugs,
    required this.indications,
  });
}

final List<AnesthesiaProtocol> initialProtocolData = [
  AnesthesiaProtocol(
    name: 'Standard Healthy (ASA I-II)',
    description: 'Balanced protocol for healthy young patients undergoing routine procedures.',
    drugs: {
      'Pre-med': 'Dexmedetomidine (5-10 mcg/kg) + Butorphanol (0.2 mg/kg) IM',
      'Induction': 'Propofol (4 mg/kg) or Alfaxalone (2 mg/kg) IV to effect',
      'Maintenance': 'Isoflurane or Sevoflurane in Oxygen',
      'Recovery': 'Atipamezole (half volume of Dex) if needed',
    },
    indications: 'Spay, Neuter, Dental prophylaxis, Mass removal',
  ),
  AnesthesiaProtocol(
    name: 'Geriatric / Cardiac',
    description: 'Opioid-based protocol to minimize cardiovascular depression.',
    drugs: {
      'Pre-med': 'Midazolam (0.2 mg/kg) + Methadone (0.2 mg/kg) IM/IV',
      'Induction': 'Etomidate (0.5-2 mg/kg) or Alfaxalone IV slowly',
      'Maintenance': 'Isoflurane (low concentration) + Fentanyl CRI',
      'Post-Op': 'Buprenorphine (0.02 mg/kg)',
    },
    indications: 'Older patients, known murmurs, stable heart disease',
  ),
  AnesthesiaProtocol(
    name: 'Brachycephalic',
    description: 'Focus on rapid intubation and airway control.',
    drugs: {
      'Pre-med': 'Acepromazine (low dose) + Butorphanol',
      'Anti-emetic': 'Maropitant (1 mg/kg) IV/SC 1hr prior',
      'Induction': 'Propofol IV to effect (rapid control)',
      'Special': 'Pre-oxygenate 5 mins; keep intubated as long as possible',
    },
    indications: 'Pugs, Bulldogs, Frenchies, Persian cats',
  ),
];
