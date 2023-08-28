part of 'get_all_posts_bloc.dart';

abstract class GetPostsEvent extends Equatable {
  const GetPostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends GetPostsEvent {}

class RefreshPostsEvent extends GetPostsEvent {}
