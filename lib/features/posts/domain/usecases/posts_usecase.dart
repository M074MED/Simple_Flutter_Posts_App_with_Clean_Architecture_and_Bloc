import '../repositories/posts_repository.dart';

abstract class PostsUseCase {
  final PostsRepository postsRepository;
  PostsUseCase(this.postsRepository);
}
