import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'post_provider.dart';

class PostListScreen extends ConsumerWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == posts.length) {
                  // 最後の要素が表示されたときにページネーションを実行
                  ref.read(postProvider.notifier).fetchPosts();
                  return const Center(child: CircularProgressIndicator());
                }

                final post = posts[index];
                return ListTile(
                  leading: Image.network(post.imageUrl, width: 50, height: 50),
                  title: Text(post.title),
                  subtitle: Text(
                      'Likes: ${post.likeCount}, Comments: ${post.commentCount}'),
                );
              },
            ),
    );
  }
}
