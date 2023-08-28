import '../../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<String> addPost(PostModel postModel);
  Future<String> updatePost(PostModel postModel);
  Future<String> deletePost(int postId);
}
