import 'package:hive/hive.dart';

part 'inventory_item.g.dart';

@HiveType(typeId: 14)
class InventoryItem extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String category;
  @HiveField(2)
  int quantity;
  @HiveField(3)
  final String unit; // e.g., vials, boxes, pills
  @HiveField(4)
  final int reorderLevel;

  InventoryItem({
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.reorderLevel,
  });
}
