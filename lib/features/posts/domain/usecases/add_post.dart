import 'package:dartz/dartz.dart';
import '../entities/post.dart';
import '../../../../core/errors/failures/failure.dart';
import 'posts_usecase.dart';

class AddPostUseCase extends PostsUseCase {
  AddPostUseCase(super.postsRepository);
  
  Future<Either<Failure, String>> call(Post post) async {
    return await postsRepository.addPost(post);
  }
}
