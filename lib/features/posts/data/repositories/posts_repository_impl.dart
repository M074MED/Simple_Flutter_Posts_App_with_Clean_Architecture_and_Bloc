import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions/empty_cache_exception.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/errors/failures/empty_cache_failure.dart';
import '../../../../core/errors/failures/failure.dart';
import '../../../../core/errors/failures/offline_failure.dart';
import '../../../../core/errors/failures/server_failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/local/post_local_data_source.dart';
import '../datasources/remote/post_remote_data_source.dart';
import '../models/post_model.dart';

typedef DeleteOrUpdateOrAddPost = Future<String>
    Function(); // or typedef Future<String> DeleteOrUpdateOrAddPost();

class PostsRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource _remoteDataSource;
  final PostLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  PostsRepositoryImpl({
    required PostRemoteDataSource remoteDataSource,
    required PostLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await _networkInfo.isConnected) {
      try {
        final remotePosts = await _remoteDataSource.getAllPosts();
        await _localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await _localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> addPost(Post post) async {
    final postModel = PostModel(title: post.title, body: post.body);

    return await _getMessage(() => _remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, String>> deletePost(int postId) async {
    return await _getMessage(() => _remoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, String>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => _remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, String>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await deleteOrUpdateOrAddPost());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
