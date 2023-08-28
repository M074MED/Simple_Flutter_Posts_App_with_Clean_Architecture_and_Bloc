import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exceptions/empty_cache_exception.dart';
import '../../models/post_model.dart';
import 'post_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String CACHED_POSTS_KEY = "cached_posts";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences _sharedPreferences;

  PostLocalDataSourceImpl({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    _sharedPreferences.setString(
        CACHED_POSTS_KEY, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = _sharedPreferences.getString(CACHED_POSTS_KEY);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
