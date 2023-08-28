import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failure.dart';
import '../entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, String>> addPost(Post post);
  Future<Either<Failure, String>> updatePost(Post post);
  Future<Either<Failure, String>> deletePost(int id);
}
