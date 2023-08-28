import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import '../entities/post.dart';
import 'posts_usecase.dart';

class GetAllPostsUseCase extends PostsUseCase {
  GetAllPostsUseCase(super.postsRepository);

  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
