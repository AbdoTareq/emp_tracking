import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../export.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/post/presentation/pages/posts_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final user = sl<FirebaseAuth>().currentUser;
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: user == null),
        AutoRoute(page: PostsRoute.page, initial: user != null),
      ];
}
