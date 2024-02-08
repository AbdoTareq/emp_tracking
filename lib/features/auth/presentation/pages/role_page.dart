import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/app_router.dart';

import '../cubit/auth_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../export.dart';

@RoutePage()
class RolePage extends HookWidget {
  RolePage({super.key});
  final controller = sl<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedCornerButton(
            color: kPrimaryColor,
            onPressed: () {
              context.navigateTo(AuthRoute());
            },
            child: 'Admin'.tr().text.white.bold.xl.make().p8(),
          ).wFull(context).py16(),
          RoundedCornerButton(
            color: kPrimaryColor,
            onPressed: () {
              context.navigateTo(AuthEmployeeRoute());
            },
            child: 'Employee'.tr().text.white.bold.xl.make().p8(),
          ).wFull(context),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}
