import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures/failure.dart';
import 'posts_usecase.dart';

class DeletePostUseCase extends PostsUseCase {
  DeletePostUseCase(super.postsRepository);

  Future<Either<Failure, String>> call(int postId) async {
    return await postsRepository.deletePost(postId);
  }
}
