import 'package:dartz/dartz.dart';
import 'package:flutter_new_template/core/network/base_requests.dart';
import 'package:flutter_new_template/features/post/data/models/post_model.dart';
import 'package:flutter_new_template/features/post/domain/entities/post.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/post_local_data_source.dart';

class PostsRepositoryImpl implements PostsRepository {
  final BaseRequests remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});
  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async {
    final res = await remoteDataSource.get('posts');
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        final posts = postsFromJson(serverResponse.data);
        localDataSource.cachePosts(posts);
        return right(posts);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    final res = await remoteDataSource.post('posts', postModel.toJson());
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    final res =
        await remoteDataSource.put("posts/${post.id}", postModel.toJson());
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    final res = await remoteDataSource.delete("posts/$postId", null);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(unit);
      },
    );
  }
}
