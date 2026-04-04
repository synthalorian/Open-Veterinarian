import 'package:flutter/foundation.dart';

@immutable
class ClientFactSheet {
  final String title;
  final String description;
  final List<String> keyPoints;
  final List<String> whatToDo;

  const ClientFactSheet({
    required this.title,
    required this.description,
    required this.keyPoints,
    required this.whatToDo,
  });
}

final List<ClientFactSheet> initialFactSheets = [
  const ClientFactSheet(
    title: 'Post-Surgical Care',
    description: 'Guidelines for caring for your pet after surgery and anesthesia.',
    keyPoints: [
      'Keep your pet in a quiet, warm, and dry environment.',
      'Check the incision site twice daily for redness, swelling, or discharge.',
      'Restrict activity: no running, jumping, or rough play for 10-14 days.'
    ],
    whatToDo: [
      'Administer all prescribed medications as directed.',
      'Prevent licking of the incision by using an Elizabethan collar.',
      'Call the clinic if your pet is excessively lethargic or stops eating.'
    ],
  ),
  const ClientFactSheet(
    title: 'Administering Eye Drops',
    description: 'Helpful tips for successfully giving eye medications.',
    keyPoints: [
      'Most eye drops should be given 5-10 minutes apart if multiple are used.',
      'Wash your hands before and after administration.'
    ],
    whatToDo: [
      'Hold the bottle between your thumb and index finger.',
      'Tilt the pets head slightly upward.',
      'Place a drop into the corner of the eye without touching the eye with the bottle tip.'
    ],
  ),
];
