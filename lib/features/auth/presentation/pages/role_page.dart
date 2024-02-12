import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/app_router.dart';

import '../../../../export.dart';

@RoutePage()
class RolePage extends HookWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
    ).pSymmetric(h: 16));
  }
}
