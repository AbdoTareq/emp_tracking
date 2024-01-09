import 'package:auto_route/auto_route.dart';

import '../features/post/presentation/pages/posts_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: PostsRoute.page, initial: true),
      ];
}
