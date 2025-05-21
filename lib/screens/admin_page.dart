import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/item_controller.dart';
import '../models/item.dart';
import '../widgets/item_form.dart';
import '../widgets/item_list.dart';
import 'login_page.dart'; 

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ItemController controller = ItemController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  bool isLibrary = true;
  int? editingIndex;
  String? currentDocId;

Future<void> _signOut(BuildContext context) async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '1021529125725-k8eq13vk61dfa5r04v4b7ac3lrl90lvf.apps.googleusercontent.com', 
    );

    // Sign out from Google if signed in
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect(); // Removes permissions
      await googleSignIn.signOut();    // Fully signs out
    }

    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Navigate to login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  } catch (e) {
    print('Sign out failed: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed: $e ')),
    );
  }
}
  void _submit() {
    final name = nameController.text.trim();
    final desc = descController.text.trim();

    if (name.isEmpty) return;

    final newItem = Item(name: name, description: desc);

    if (editingIndex == null) {
      controller.addItem(isLibrary, newItem);
    } else {
      controller.updateItem(isLibrary, currentDocId!, newItem);
      editingIndex = null;
      currentDocId = null;
    }

    nameController.clear();
    descController.clear();
  }

  void _edit(int index, String docId, Item item) {
    nameController.text = item.name;
    descController.text = item.description;

    setState(() {
      editingIndex = index;
      currentDocId = docId;
    });
  }

  void _delete(String docId) {
    controller.deleteItem(isLibrary, docId);
  }

  Widget _buildTabButton(bool forLibrary) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isLibrary == forLibrary
              ? Color.fromARGB(255, 235, 141, 1)
              : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () => setState(() => isLibrary = forLibrary),
        child: Text(
          forLibrary ? 'LIBRARY' : 'CATALOG',
          style: TextStyle(
            color: isLibrary == forLibrary
                ? Color.fromARGB(255, 235, 141, 1)
                : Color.fromARGB(255, 2, 245, 215),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADMIN PAGE'),
        titleTextStyle: TextStyle(
          color: isLibrary
              ? const Color.fromARGB(255, 235, 141, 1)
              : const Color.fromARGB(255, 253, 141, 1),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 15, 17),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: const Color.fromARGB(255, 255, 0, 0)),
            tooltip: 'Logout',
            onPressed: () => _signOut(context),
          ),
          _buildTabButton(true),
          _buildTabButton(false),
        ],
      ),
  body: Builder(
  builder: (context) => Container(
    color: Color.fromARGB(255, 0, 44, 54),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ItemForm(
            nameController: nameController,
            descController: descController,
            onSubmit: _submit,
            isEditing: editingIndex != null,
          ),
          SizedBox(height: 30),
         Expanded(
  child: Builder(
    builder: (_) =>StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection(isLibrary ? 'components' : 'catalog')
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Center(child: Text(' EMPTY!'));
    }

    final docs = snapshot.data!.docs;

   final items = docs.map((doc) {
  final data = doc.data() as Map<String, dynamic>;
  return Item(
    name: data['componentName'] ?? '',
    description: data['description'] ?? '',
  );
}).toList();

final docIds = docs.map((doc) => doc.id).toList();

return ItemList(
  items: items,
  onEdit: (index) {
    final item = items[index];
    final docId = docIds[index];
    _edit(index, docId, item);
  },
  onDelete: (index) {
    final docId = docIds[index];
    _delete(docId);
  },
);

  },
)

  ),
),

        ],
      ),
    ),
  ),
),

    );
  }
}
