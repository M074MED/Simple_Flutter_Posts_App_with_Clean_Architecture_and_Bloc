import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
// import 'core/network/network_info_impl_ICC.dart';
import 'core/network/network_info_impl_ICCP.dart';
import 'features/posts/data/datasources/local/post_local_data_source.dart';
import 'features/posts/data/datasources/local/post_local_data_source_impl.dart';
import 'features/posts/data/datasources/remote/post_remote_data_source.dart';
import 'features/posts/data/datasources/remote/post_remote_data_source_impl.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'features/posts/presentation/bloc/get_all_posts/get_all_posts_bloc.dart';

import 'features/posts/domain/usecases/add_post.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc
  sl.registerFactory(() => GetPostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

// UseCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

// Repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

// DataSources
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));

//! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplICC(sl()));  // for InternetConnectionChecker()
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplICCP(sl()));

//! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => InternetConnection());
}
