import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';
import '../../../domain/usecases/add_post.dart';

import '../../../../../core/errors/failures/failure.dart';
import '../../../domain/entities/post.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase _addPost;
  final DeletePostUseCase _deletePost;
  final UpdatePostUseCase _updatePost;

  AddUpdateDeletePostBloc(
      {required AddPostUseCase addPost,
      required DeletePostUseCase deletePost,
      required UpdatePostUseCase updatePost})
      : _addPost = addPost,
        _deletePost = deletePost,
        _updatePost = updatePost,
        super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      emit(LoadingAddUpdateDeletePostState());

      late final Either<Failure, String> failureOrDoneMessage;
      if (event is AddPostEvent) {
        failureOrDoneMessage = await _addPost(event.post);
      } else if (event is UpdatePostEvent) {
        failureOrDoneMessage = await _updatePost(event.post);
      } else if (event is DeletePostEvent) {
        failureOrDoneMessage = await _deletePost(event.postId);
      }
      emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage));
    });
  }

  AddUpdateDeletePostState _eitherDoneMessageOrErrorState(
          Either<Failure, String> either) =>
      either.fold(
        (failure) => ErrorAddUpdateDeletePostState(message: failure.message),
        (doneMessage) => MessageAddUpdateDeletePostState(message: doneMessage),
      );
}
