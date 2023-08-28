import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';

import '../widgets/post_details_page/post_details_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text("Post Details"),
      );

  Widget? _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailsWidget(post: post),
      ),
    );
  }
}
