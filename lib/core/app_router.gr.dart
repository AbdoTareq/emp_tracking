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
    ClientDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ClientDetailsRouteArgs>(
          orElse: () => const ClientDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ClientDetailsPage(
          key: args.key,
          item: args.item,
        ),
      );
    },
    ClientRoute.name: (routeData) {
      final args = routeData.argsAs<ClientRouteArgs>(
          orElse: () => const ClientRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ClientPage(key: args.key),
      );
    },
    EmployeeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeDetailsRouteArgs>(
          orElse: () => const EmployeeDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmployeeDetailsPage(
          key: args.key,
          employee: args.employee,
        ),
      );
    },
    EmployeeRoute.name: (routeData) {
      final args = routeData.argsAs<EmployeeRouteArgs>(
          orElse: () => const EmployeeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EmployeePage(key: args.key),
      );
    },
    MaterialDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<MaterialDetailsRouteArgs>(
          orElse: () => const MaterialDetailsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MaterialDetailsPage(
          key: args.key,
          item: args.item,
        ),
      );
    },
    MaterialsRoute.name: (routeData) {
      final args = routeData.argsAs<MaterialsRouteArgs>(
          orElse: () => const MaterialsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MaterialsPage(key: args.key),
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
/// [ClientDetailsPage]
class ClientDetailsRoute extends PageRouteInfo<ClientDetailsRouteArgs> {
  ClientDetailsRoute({
    Key? key,
    ClientModel? item,
    List<PageRouteInfo>? children,
  }) : super(
          ClientDetailsRoute.name,
          args: ClientDetailsRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'ClientDetailsRoute';

  static const PageInfo<ClientDetailsRouteArgs> page =
      PageInfo<ClientDetailsRouteArgs>(name);
}

class ClientDetailsRouteArgs {
  const ClientDetailsRouteArgs({
    this.key,
    this.item,
  });

  final Key? key;

  final ClientModel? item;

  @override
  String toString() {
    return 'ClientDetailsRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [ClientPage]
class ClientRoute extends PageRouteInfo<ClientRouteArgs> {
  ClientRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ClientRoute.name,
          args: ClientRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ClientRoute';

  static const PageInfo<ClientRouteArgs> page = PageInfo<ClientRouteArgs>(name);
}

class ClientRouteArgs {
  const ClientRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ClientRouteArgs{key: $key}';
  }
}

/// generated route for
/// [EmployeeDetailsPage]
class EmployeeDetailsRoute extends PageRouteInfo<EmployeeDetailsRouteArgs> {
  EmployeeDetailsRoute({
    Key? key,
    EmployeeModel? employee,
    List<PageRouteInfo>? children,
  }) : super(
          EmployeeDetailsRoute.name,
          args: EmployeeDetailsRouteArgs(
            key: key,
            employee: employee,
          ),
          initialChildren: children,
        );

  static const String name = 'EmployeeDetailsRoute';

  static const PageInfo<EmployeeDetailsRouteArgs> page =
      PageInfo<EmployeeDetailsRouteArgs>(name);
}

class EmployeeDetailsRouteArgs {
  const EmployeeDetailsRouteArgs({
    this.key,
    this.employee,
  });

  final Key? key;

  final EmployeeModel? employee;

  @override
  String toString() {
    return 'EmployeeDetailsRouteArgs{key: $key, employee: $employee}';
  }
}

/// generated route for
/// [EmployeePage]
class EmployeeRoute extends PageRouteInfo<EmployeeRouteArgs> {
  EmployeeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EmployeeRoute.name,
          args: EmployeeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'EmployeeRoute';

  static const PageInfo<EmployeeRouteArgs> page =
      PageInfo<EmployeeRouteArgs>(name);
}

class EmployeeRouteArgs {
  const EmployeeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'EmployeeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MaterialDetailsPage]
class MaterialDetailsRoute extends PageRouteInfo<MaterialDetailsRouteArgs> {
  MaterialDetailsRoute({
    Key? key,
    MaterialModel? item,
    List<PageRouteInfo>? children,
  }) : super(
          MaterialDetailsRoute.name,
          args: MaterialDetailsRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'MaterialDetailsRoute';

  static const PageInfo<MaterialDetailsRouteArgs> page =
      PageInfo<MaterialDetailsRouteArgs>(name);
}

class MaterialDetailsRouteArgs {
  const MaterialDetailsRouteArgs({
    this.key,
    this.item,
  });

  final Key? key;

  final MaterialModel? item;

  @override
  String toString() {
    return 'MaterialDetailsRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [MaterialsPage]
class MaterialsRoute extends PageRouteInfo<MaterialsRouteArgs> {
  MaterialsRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MaterialsRoute.name,
          args: MaterialsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MaterialsRoute';

  static const PageInfo<MaterialsRouteArgs> page =
      PageInfo<MaterialsRouteArgs>(name);
}

class MaterialsRouteArgs {
  const MaterialsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MaterialsRouteArgs{key: $key}';
  }
}
