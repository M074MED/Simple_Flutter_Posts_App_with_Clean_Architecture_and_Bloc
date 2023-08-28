import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/failures/failure.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'get_all_posts_event.dart';
part 'get_all_posts_state.dart';

class GetPostsBloc extends Bloc<GetPostsEvent, GetPostsState> {
  final GetAllPostsUseCase _getAllPosts;

  GetPostsBloc({required GetAllPostsUseCase getAllPosts})
      : _getAllPosts = getAllPosts,
        super(PostsInitial()) {
    on<GetPostsEvent>((event, emit) async {
      emit(LoadingPostsState());

      final failureOrPosts = await _getAllPosts();
      emit(_mapFailureOrPostsToState(failureOrPosts));
    });
  }

  GetPostsState _mapFailureOrPostsToState(Either<Failure, dynamic> either) =>
      either.fold(
        (failure) => ErrorPostsState(message: failure.message),
        (posts) => LoadedPostsState(posts: posts),
      );
}
