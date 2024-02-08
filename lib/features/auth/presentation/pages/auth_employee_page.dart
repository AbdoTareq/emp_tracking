import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/feature/data/models/employee_model.dart';
import 'package:employee_management/features/employee/presentation/employee_cubit.dart';
import '../../../../core/app_router.dart';
import '../cubit/auth_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/view/widgets/rounded_corner_loading_button.dart';
import '../../../../export.dart';

@RoutePage()
class AuthEmployeePage extends HookWidget {
  AuthEmployeePage({super.key});
  final controller = sl<AuthCubit>();
  final empController = sl<EmployeeCubit>();

  @override
  Widget build(BuildContext context) {
    final empTextController = useTextEditingController();
    return Scaffold(
        body: Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            autofillHints: const [AutofillHints.email],
            controller: empTextController,
            inputType: TextInputType.emailAddress,
            hint: LocaleKeys.mail,
            spaceAfter: false,
            prefixIcon: const Icon(Icons.email),
            validate: (value) =>
                value!.isNotEmpty ? null : LocaleKeys.mail.tr(),
          ),
          15.rh.heightBox,
          RoundedCornerLoadingButton(
            color: kPrimaryColor,
            onPressed: () async {
              final res = await controller.login(
                'emp@gmail.com',
                '123456',
              );
              logger.i(res);
              if (res != null) {
                EmployeeModel? res2 =
                    await empController.getById(empTextController.text);
                if (res2 != null) {
                  context.replaceRoute(EmployeeRoute());
                }
              }
            },
            child: LocaleKeys.login.tr().text.white.bold.xl.make(),
          ).wFull(context),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}
