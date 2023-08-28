import 'dart:convert';

import '../../../../../core/strings/messages.dart';
import '../../../../../core/errors/exceptions/server_exception.dart';
import '../../models/post_model.dart';
import 'post_remote_data_source.dart';
import 'package:http/http.dart' as http;

const String BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client _client;

  PostRemoteDataSourceImpl({required http.Client client}) : _client = client;

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await _client.get(
      Uri.parse("$BASE_URL/posts/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> addPost(PostModel postModel) async {
  final responseBody = {
  "title": postModel.title,
  "body": postModel.body
  };
  
    final response = await _client.post(
      Uri.parse("$BASE_URL/posts/"),
      body: responseBody,
    );
    if (response.statusCode == 201) {
      return Future.value(ADD_SUCCESS_MESSAGE);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> deletePost(int postId) async {
    final response = await _client.delete(
      Uri.parse("$BASE_URL/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(DELETE_SUCCESS_MESSAGE);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> updatePost(PostModel postModel) async {
  final postId = postModel.id.toString();
  final responseBody = {
  "title": postModel.title,
  "body": postModel.body
  };
    final response = await _client.patch(
      Uri.parse("$BASE_URL/posts/$postId"),
      body: responseBody,
    );
    if (response.statusCode == 200) {
      return Future.value(UPDATE_SUCCESS_MESSAGE);
    } else {
      throw ServerException();
    }
  }
}
