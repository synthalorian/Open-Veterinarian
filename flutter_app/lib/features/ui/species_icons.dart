import 'package:flutter/material.dart';

class SpeciesIcon extends StatelessWidget {
  final String species;
  final double size;
  final Color color;

  const SpeciesIcon({
    super.key,
    required this.species,
    this.size = 24.0,
    this.color = Colors.cyanAccent,
  });

  @override
  Widget build(BuildContext context) {
    String iconData;
    
    switch (species.toLowerCase()) {
      case 'canine':
        iconData = 'dog';
        break;
      case 'feline':
        iconData = 'cat';
        break;
      case 'equine':
        iconData = 'horse';
        break;
      case 'bovine':
        iconData = 'cow';
        break;
      default:
        iconData = 'pets';
    }

    // In a real app, these would be local SVG files in assets/images/
    // For now, we will use Material Icons but wrap them in a consistent UI helper
    // to simulate where SVGs would go.
    IconData icon;
    switch (iconData) {
      case 'dog':
        icon = Icons.pets;
        break;
      case 'cat':
        icon = Icons.pets;
        break;
      case 'horse':
        icon = Icons.cruelty_free;
        break;
      case 'cow':
        icon = Icons.agriculture;
        break;
      default:
        icon = Icons.pets;
    }

    return Icon(icon, size: size, color: color);
  }
}
