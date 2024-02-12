import 'package:employee_management/core/app_router.dart';
import 'package:employee_management/features/employee/presentation/employee_cubit.dart';

import '../../../../core/view/widgets/rounded_corner_loading_button.dart';
import '../../../../export.dart';

@RoutePage()
class AuthEmployeePage extends HookWidget {
  AuthEmployeePage({super.key});
  final empController = sl<EmployeeCubit>()..loginEmployee();
  final GlobalKey<FormState> formKey = GlobalKey();

  validate() => formKey.currentState!.validate();

  loginClick(
      BuildContext context, TextEditingController empTextController) async {
    if (!validate()) return;
    final emp = await empController.getById(empTextController.text);
    logger.i(emp);
    if (emp == null) return;
    context.router.replaceAll([EmployeeRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final empTextController = useTextEditingController();
    return Scaffold(
        body: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            autofillHints: const [AutofillHints.email],
            controller: empTextController,
            inputType: TextInputType.emailAddress,
            maxLines: 1,
            hint: LocaleKeys.userId,
            spaceAfter: false,
            prefixIcon: const Icon(Icons.person),
            validate: (value) => value!.isNotEmpty ? null : LocaleKeys.war.tr(),
          ),
          15.rh.heightBox,
          RoundedCornerLoadingButton(
            color: kPrimaryColor,
            onPressed: () async => loginClick(context, empTextController),
            child: LocaleKeys.login.tr().text.white.bold.xl.make(),
          ).wFull(context),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}
