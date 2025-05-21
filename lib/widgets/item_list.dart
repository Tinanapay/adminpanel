import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;
  final void Function(int) onEdit;
  final void Function(int) onDelete;

  const ItemList({
    super.key,
    required this.items,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];
          return Card(
             color: const Color.fromARGB(255, 0, 25, 28), 
  elevation: 4,
  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    side: BorderSide(color: const Color.fromARGB(255, 45, 155, 167), width: 1),
  ),
            child: ListTile(
  title: Text(
    item.name,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: const Color.fromARGB(255, 235, 141, 1),
    ),
  ),
  subtitle: Text(
    item.description,
    style: TextStyle(
      fontStyle: FontStyle.italic,
      color: Color.fromARGB(255, 0, 191, 168),
    ),
  ),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(Icons.edit, color: Color(0xFF00838F)),
        onPressed: () => onEdit(index),
      ),
      IconButton(
        icon: Icon(Icons.delete, color: Color(0xFFD32F2F)),
        onPressed: () => onDelete(index),
      ),
    ],
  ),
      )
          );
        },
      );
    
  }
}
