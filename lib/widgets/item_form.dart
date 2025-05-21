import 'package:flutter/material.dart';


class ItemForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descController;
  final VoidCallback onSubmit;
  final bool isEditing;

  const ItemForm({
    super.key,
    required this.nameController,
    required this.descController,
    required this.onSubmit,
    required this.isEditing,
  });
@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: TextField(
  controller: nameController,
  style: TextStyle(color: const Color.fromARGB(255, 235, 141, 1), fontWeight: FontWeight.bold),
  decoration: InputDecoration(
    labelText: ' Component Name',
    labelStyle: TextStyle(color:  const Color.fromARGB(255, 5, 226, 204)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: const Color.fromARGB(255, 235, 141, 1), width: 2),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Color.fromARGB(255, 0, 26, 25), 
  ),
),


          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
  controller: descController,
  style: TextStyle(color: const Color.fromARGB(255, 235, 141, 1), fontWeight: FontWeight.bold),
  decoration: InputDecoration(
    labelText: 'Contents',
    labelStyle: TextStyle(color: const Color.fromARGB(255, 5, 226, 204)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
      focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: const Color.fromARGB(255, 235, 141, 1), width: 2),
    ),
    filled: true,
    fillColor:Color.fromARGB(255, 0, 26, 25), 
  ),
)
          ),
          SizedBox(width: 10),
         ElevatedButton(
  onPressed: onSubmit,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 235, 141, 1),
    foregroundColor: Colors.black,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      
    ),
    elevation: 4,
  ),
  child: Text(
    isEditing ? 'Update' : 'Add',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  ),
),

        ],
      ),
    ],
  );
}
}