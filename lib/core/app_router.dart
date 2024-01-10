import 'package:auto_route/auto_route.dart';

import '../export.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/post/presentation/pages/posts_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: true),
        AutoRoute(page: PostsRoute.page),
      ];
}
