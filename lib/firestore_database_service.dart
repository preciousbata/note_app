import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabaseService {
  final FirebaseFirestore firebaseFirestore;

  FirestoreDatabaseService(this.firebaseFirestore);

  Future<DocumentReference<Map<String, dynamic>>>
      saveToCollection(String collectionPath,
          Map<String, dynamic> data) async {
    final collection =
        firebaseFirestore.collection(collectionPath);
    return collection.add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getCollections(String collectionPath) {
    return firebaseFirestore
        .collection(collectionPath)
        .snapshots();
  }

  Future updateCollection(
      {required String collectionPath,
      required String referenceId,
      required Map<String, dynamic> data}) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(referenceId)
        .update(data);
  }

  void deleteCollection(
      String collectionPath, String referenceId) {
    firebaseFirestore
        .collection(collectionPath)
        .doc(referenceId)
        .delete();
  }
}
