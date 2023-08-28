part of 'get_all_posts_bloc.dart';

abstract class GetPostsState extends Equatable {
  const GetPostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends GetPostsState {}

class LoadingPostsState extends GetPostsState {}

class LoadedPostsState extends GetPostsState {
  final List<Post> posts;

  const LoadedPostsState({required this.posts});

  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends GetPostsState {
  final String message;

  const ErrorPostsState({required this.message});

  @override
  List<Object> get props => [message];
}
