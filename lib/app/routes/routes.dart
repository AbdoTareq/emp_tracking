import 'package:flutter_new_template/app/post/post_screen.dart';
import 'package:go_router/go_router.dart';

import '../../export.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

final routes = GoRouter(
  navigatorKey: navKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => PostScreen(),
    ),
  ],
);
