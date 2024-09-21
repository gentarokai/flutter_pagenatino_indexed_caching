import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'post_model.dart';

final postProvider =
    StateNotifierProvider<PostNotifier, List<PostMetaData>>((ref) {
  return PostNotifier(ref as WidgetRef);
});

class PostNotifier extends StateNotifier<List<PostMetaData>> {
  PostNotifier(this.ref) : super([]);

  final WidgetRef ref;
  DocumentSnapshot? _lastDocument;

  Future<void> fetchPosts() async {
    Query query = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt')
        .limit(10);
    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }
    final snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
      final newPosts = snapshot.docs.map((doc) {
        // ここで型を明示的に指定します
        final data = doc.data() as Map<String, dynamic>;
        return PostMetaData.fromMap(data, doc.id);
      }).toList();
      state = [...state, ...newPosts];
    }
  }
}
