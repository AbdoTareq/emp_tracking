import 'package:flutter_new_template/models/post.dart';
import 'package:flutter_new_template/repos/posts_repo.dart';

import '../../../../../export.dart';

class PostsController extends GetxController with StateMixin<List<Post>> {
  final PostsRepository repo = PostsRepositoryImp();
  ScrollController scrollController = ScrollController();
  int _pageNum = 0;

  @override
  Future<void> onReady() async {
    await handleRequestWithoutLoading(() async {
      change([], status: RxStatus.loading());
      await _getPosts();
    }, onError: (e) => change([], status: RxStatus.error(e.message)));
    getMoreListener();
    super.onReady();
  }

  _getPosts() async {
    final res = await repo.getAll(pageNum: _pageNum);
    res.fold((_) {}, (r) {
      change([...state!, ...postsFromJson(r.data)], status: RxStatus.success());
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
