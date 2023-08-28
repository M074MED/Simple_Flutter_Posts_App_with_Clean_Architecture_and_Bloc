import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/toast_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import '../../pages/posts_page.dart';

import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
      onPressed: () => _deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  _deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddUpdateDeletePostBloc,
              AddUpdateDeletePostState>(builder: (context, state) {
            if (state is LoadingAddUpdateDeletePostState) {
              return const AlertDialog(
                title: LoadingWidget(),
              );
            }
            return DeleteDialogWidget(postId: postId);
          }, listener: (context, state) {
            if (state is MessageAddUpdateDeletePostState) {
              ToastMessage(message: state.message, bgColor: Colors.green)
                  .show();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const PostsPage(),
                  ),
                  (route) => false);
            } else if (state is ErrorAddUpdateDeletePostState) {
              Navigator.of(context).pop();
              ToastMessage(message: state.message, bgColor: Colors.redAccent)
                  .show();
            }
          });
        });
  }
}
