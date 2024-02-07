import 'package:auto_route/auto_route.dart';
import 'package:employee_management/features/attendance/presentation/page.dart';
import 'package:employee_management/features/clients/presentation/details_page.dart';
import 'package:employee_management/features/clients/presentation/page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../export.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/employee/presentation/employee_details_page.dart';
import '../features/employee/presentation/employee_page.dart';
import '../features/materials/presentation/material_details_page.dart';
import '../features/materials/presentation/materials_page.dart';
import 'feature/data/models/client_model.dart';
import 'feature/data/models/employee_model.dart';
import 'feature/data/models/material_model.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final user = sl<FirebaseAuth>().currentUser;
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: user == null),
        AutoRoute(page: EmployeeRoute.page, initial: user != null, children: [
          AutoRoute(page: EmployeeDetailsRoute.page),
        ]),
        AutoRoute(page: MaterialsRoute.page),
        AutoRoute(page: MaterialDetailsRoute.page),
        AutoRoute(page: ClientRoute.page),
        AutoRoute(page: ClientDetailsRoute.page),
        AutoRoute(page: CheckInRoute.page),
      ];
}
