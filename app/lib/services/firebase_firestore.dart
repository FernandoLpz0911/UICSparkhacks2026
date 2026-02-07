/// Database calls are here
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a project
  Future<void> addProject({
    required String title,
    required String description,
    required String ownerId,
  }) async {
    await _db.collection('projects').add({
      'title': title,
      'description': description,
      'ownerId': ownerId,
      'createdAt': Timestamp.now(),
    });
  }

  // Get all projects
  Stream<QuerySnapshot> getProjects() {
    return _db
        .collection('projects')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Update project
  Future<void> updateProject(String projectId, String newTitle) async {
    await _db.collection('projects').doc(projectId).update({
      'title': newTitle,
    });
  }

  // Delete project
  Future<void> deleteProject(String projectId) async {
    await _db.collection('projects').doc(projectId).delete();
  }
}