import 'package:flutter_new_template/app/post/post_screen.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => PostScreen(),
    ),
  ],
);
