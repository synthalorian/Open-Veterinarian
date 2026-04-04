import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../services/database_service.dart';
import '../ui/glow_card.dart';
import 'inventory_item.dart';

class InventoryTrackerView extends StatelessWidget {
  const InventoryTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INVENTORY TRACKER'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.cyanAccent),
            onPressed: () => _showAddItemDialog(context),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: DatabaseService.getInventoryBox().listenable(),
        builder: (context, Box<InventoryItem> box, _) {
          final items = box.values.toList();
          
          if (items.isEmpty) {
            return const Center(
              child: Text('Inventory empty. Add items to track.', style: TextStyle(color: Colors.grey)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isLow = item.quantity <= item.reorderLevel;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlowCard(
                  glowColor: isLow ? Colors.redAccent : Colors.cyanAccent,
                  child: ListTile(
                    title: Text(item.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    subtitle: Text(item.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
                          onPressed: () {
                            if (item.quantity > 0) {
                              item.quantity--;
                              item.save();
                            }
                          },
                        ),
                        Text(
                          '${item.quantity}',
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold, 
                            color: isLow ? Colors.redAccent : Colors.white,
                            fontFamily: 'monospace',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, color: Colors.cyanAccent),
                          onPressed: () {
                            item.quantity++;
                            item.save();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final quantityController = TextEditingController();
    final reorderController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('ADD INVENTORY ITEM', style: TextStyle(color: Colors.cyanAccent, fontSize: 16)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Item Name')),
              TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Category')),
              TextField(controller: quantityController, decoration: const InputDecoration(labelText: 'Current Quantity'), keyboardType: TextInputType.number),
              TextField(controller: reorderController, decoration: const InputDecoration(labelText: 'Reorder Level'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              final newItem = InventoryItem(
                name: nameController.text,
                category: categoryController.text,
                quantity: int.tryParse(quantityController.text) ?? 0,
                unit: 'units',
                reorderLevel: int.tryParse(reorderController.text) ?? 5,
              );
              DatabaseService.getInventoryBox().add(newItem);
              Navigator.pop(context);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }
}
