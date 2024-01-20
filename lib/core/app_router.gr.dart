// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AuthPage(key: args.key),
      );
    },
    EmployeeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeDetailsRouteArgs>(
          orElse: () => const EmployeeDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmployeeDetailsPage(employee: args.employee),
      );
    },
    EmployeeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmployeePage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<AuthRouteArgs> page = PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key}';
  }
}

/// generated route for
/// [EmployeeDetailsPage]
class EmployeeDetailsRoute extends PageRouteInfo<EmployeeDetailsRouteArgs> {
  EmployeeDetailsRoute({
    EmployeeModel? employee,
    List<PageRouteInfo>? children,
  }) : super(
          EmployeeDetailsRoute.name,
          args: EmployeeDetailsRouteArgs(employee: employee),
          initialChildren: children,
        );

  static const String name = 'EmployeeDetailsRoute';

  static const PageInfo<EmployeeDetailsRouteArgs> page =
      PageInfo<EmployeeDetailsRouteArgs>(name);
}

class EmployeeDetailsRouteArgs {
  const EmployeeDetailsRouteArgs({this.employee});

  final EmployeeModel? employee;

  @override
  String toString() {
    return 'EmployeeDetailsRouteArgs{employee: $employee}';
  }
}

/// generated route for
/// [EmployeePage]
class EmployeeRoute extends PageRouteInfo<void> {
  const EmployeeRoute({List<PageRouteInfo>? children})
      : super(
          EmployeeRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
