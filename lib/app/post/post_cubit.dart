import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_template/app/post/post_state.dart';

import '../../export.dart';
import '../../models/post.dart';
import '../../repos/posts_repo.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostState(isLoading: true));

  final PostsRepository repo = PostsRepositoryImp();
  ScrollController scrollController = ScrollController();
  int _pageNum = 0;

  Future<void> loadInitialData() async {
    try {
      emit(state.copyWith(isLoading: true));
      await _getPosts();
    } catch (error) {
      logger.i(error);
      emit(state.copyWith(error: error.toString()));
    }
  }

  _getPosts() async {
    final res = await repo.getAll(pageNum: _pageNum);
    res.fold((_) {}, (r) {
      emit(state.copyWith(
          isLoading: false, data: [...state.data!, ...postsFromJson(r.data)]));
    });
  }

  void getMoreListener() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        _pageNum += 10;
        await handleRequest(() async {
          await _getPosts();
        });
      }
    });
  }
}
