import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/toast_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/post.dart';
import '../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'posts_page.dart';

import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(isUpdatePost ? "Edit Post" : "Add Post"),
      );

  Widget? _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
            builder: (context, state) {
          if (state is LoadingAddUpdateDeletePostState) {
            return const LoadingWidget();
          }
          return FormWidget(
              isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
        }, listener: (context, state) {
          if (state is MessageAddUpdateDeletePostState) {
            ToastMessage(message: state.message, bgColor: Colors.green).show();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (route) => false);
          } else if (state is ErrorAddUpdateDeletePostState) {
            ToastMessage(message: state.message, bgColor: Colors.redAccent)
                .show();
          }
        }),
      ),
    );
  }
}
