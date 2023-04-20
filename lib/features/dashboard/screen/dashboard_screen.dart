import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Dashboard"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final firebaseFireStore = FirebaseFirestore.instance;
            getCollections(firebaseFireStore);
            getSingleDocument(firebaseFireStore, "4iDqhCoKNr5No0Wne1DE");
            addDocumentToCollection(
                firebaseFireStore, {'name': "nabin"}, "categories");
          },
          label: const Text("Add")),
    );
  }

  void getCollections(FirebaseFirestore firebaseFireStore) async {
    QuerySnapshot querySnapshot =
        await firebaseFireStore.collection("categories").get();
    print(querySnapshot.docs.map((e) => e.data()).toString());
  }

  void getSingleDocument(
      FirebaseFirestore firebaseFireStore, String docID) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFireStore.collection("categories").doc(docID).get();
    print(documentSnapshot.data().toString());
  }

  void addDocumentToCollection(FirebaseFirestore firebaseFireStore,
      Map<String, dynamic> data, String collectionID) async {
    var dd = await firebaseFireStore.collection(collectionID).add(data);
    dd;
  }
}
