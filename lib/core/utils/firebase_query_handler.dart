import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/core/utils/snackbar.dart';

class FirebaseQueryHelper {
  FirebaseQueryHelper._();
  static final firebaseFireStore = FirebaseFirestore.instance;
  static Future<QuerySnapshot<Map<String, dynamic>>?> getCollections(
      {required String collectionPath}) async {
    try {
      final data = await firebaseFireStore.collection(collectionPath).get();
      return data;
    } on FirebaseException catch (e) {
      showSnackBar(
          message: e.message ?? "Something Went Wrong!!",
          type: SnackBarTypes.Error);
    }
    return null;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>? getCollectionsAsStream(
      {required String collectionPath}) {
    try {
      final data = firebaseFireStore.collection(collectionPath).snapshots();
      return data;
    } on FirebaseException catch (e) {
      showSnackBar(
          message: e.message ?? "Something Went Wrong!!",
          type: SnackBarTypes.Error);
    }
    return null;
  }

  static Future<DocumentSnapshot?> getSingleDocument(
      {required String collectionPath, required String docID}) async {
    try {
      var data =
          await firebaseFireStore.collection(collectionPath).doc(docID).get();
      data.data()?.forEach((key, value) {
        value;
      });

      return data;
    } on FirebaseException catch (e) {
      showSnackBar(
          message: e.message ?? "Something Went Wrong!!",
          type: SnackBarTypes.Error);
    }
    return null;
  }

  static void addDocumentToCollection(
      {required Map<String, dynamic> data,
      required String collectionID}) async {
    try {
      await firebaseFireStore.collection(collectionID).add(data);
      showSnackBar(
          message: "Successfully Created!!", type: SnackBarTypes.Success);
    } on FirebaseException catch (e) {
      showSnackBar(
          message: e.message ?? "Something Went Wrong!!",
          type: SnackBarTypes.Error);
    }
  }

  static void addDataToDocument({
    required String data,
    required String collectionID,
    required String docID,
  }) async {
    try {
      var categoriesArray =
          firebaseFireStore.collection(collectionID).doc(docID);
      categoriesArray.update({
        'expense_type': FieldValue.arrayUnion([data])
      });
      showSnackBar(
          message: "Successfully Created!!", type: SnackBarTypes.Success);
    } on FirebaseException catch (e) {
      showSnackBar(
          message: e.message ?? "Something Went Wrong!!",
          type: SnackBarTypes.Error);
    }
  }

  static void updateDocumentOfCollection(
      {required Map<String, dynamic> data,
      required String collectionID,
      required String docID}) async {
    try {
      await firebaseFireStore.collection(collectionID).doc(docID).update(data);
      showSnackBar(
          message: "Successfully Updated!!", type: SnackBarTypes.Success);
    } on FirebaseException catch (e) {
      showSnackBar(
          message: e.message ?? "Something Went Wrong!!",
          type: SnackBarTypes.Error);
    }
  }

  static void deleteDocumentOfCollection(
      {required String collectionID, required String docID}) async {
    try {
      await firebaseFireStore.collection(collectionID).doc(docID).delete();
      showSnackBar(
          message: "Successfully Deleted!!", type: SnackBarTypes.Success);
    } on FirebaseException catch (e) {
      showSnackBar(
          message: e.message ?? "Something Went Wrong!!",
          type: SnackBarTypes.Error);
    }
  }
}
