import 'package:auto_route/auto_route.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:employee_management/features/employee/presentation/employee_details_page.dart';
import 'package:employee_management/features/employee/presentation/employee_page.dart';
import 'package:employee_management/features/materials/data/models/material_model.dart';
import 'package:employee_management/features/materials/presentation/material_details_page.dart';
import 'package:employee_management/features/materials/presentation/materials_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../export.dart';
import '../features/auth/presentation/pages/auth_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final user = sl<FirebaseAuth>().currentUser;
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: user == null),
        // AutoRoute(page: EmployeeRoute.page, initial: user != null, children: [
        //   AutoRoute(page: EmployeeDetailsRoute.page),
        // ]),
        AutoRoute(page: MaterialsRoute.page, initial: user != null, children: [
          AutoRoute(page: MaterialDetailsRoute.page),
        ]),
      ];
}
