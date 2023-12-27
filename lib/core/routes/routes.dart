import 'package:flutter_new_template/features/post/presentation/pages/posts_page.dart';
import 'package:go_router/go_router.dart';

import '../../export.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  navigatorKey: navKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => PostsPage(),
    ),
  ],
);
