import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageIdeasPage extends StatefulWidget {
  const ManageIdeasPage({super.key});

  @override
  State<ManageIdeasPage> createState() => _ManageIdeasPageState();
}

class _ManageIdeasPageState extends State<ManageIdeasPage> {
  final _ideaController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _ideaController.dispose();
    super.dispose();
  }

  Future<void> _addIdea() async {
    if (_ideaController.text.trim().isEmpty) return;
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore.collection("ideas").add({
      "text": _ideaController.text.trim(),
      "upVotes": 0,
      "downVotes": 0,
      "userId": user.uid,
      "userEmail": user.email,
      "addedAt": FieldValue.serverTimestamp(),
    });
    _ideaController.clear();
  }

  void _deleteIdea(String docId) =>
      _firestore.collection("ideas").doc(docId).delete();

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.lightbulb_rounded,
                    size: 80,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Upravljanje idejama",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _ideaController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Nova ideja",
                      hintText: "Unesite vašu ideju",
                      prefixIcon: const Icon(Icons.edit_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _addIdea,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Dodaj ideju",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection("ideas")
                    .where("userId", isEqualTo: user?.uid ?? "")
                    .orderBy("addedAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
