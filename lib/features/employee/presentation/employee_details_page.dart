import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:employee_management/core/view/widgets/rounded_corner_loading_button.dart';
import 'package:employee_management/export.dart';
import 'package:employee_management/features/employee/data/models/employee_model.dart';
import 'package:employee_management/features/employee/presentation/employee_cubit.dart';

@RoutePage()
class EmployeeDetailsPage extends HookWidget {
  final screenCubit = sl<EmployeeCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();
  final EmployeeModel? employee;
  EmployeeDetailsPage({this.employee});

  String? getRightField(int index, EmployeeModel? emp) {
    switch (index) {
      case 0:
        return emp?.name;
      case 1:
        return emp?.jobTitle;
      default:
        return emp?.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textControllers = List.generate(
        5,
        (index) =>
            useTextEditingController(text: getRightField(index, employee)));
    return Scaffold(
        appBar: CustomAppBar(title: LocaleKeys.save),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomListTile(
                onTap: () async => await Clipboard.setData(
                    ClipboardData(text: employee?.id ?? '')),
                title: employee?.id.toString().text.make(),
                trailing: Icon(Icons.copy),
              ),
              TextInput(
                autofillHints: [AutofillHints.username],
                controller: textControllers[0],
                inputType: TextInputType.name,
                hint: LocaleKeys.name,
                spaceAfter: false,
                prefixIcon: Icon(Icons.person),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.name.tr(),
              ),
              TextInput(
                autofillHints: [AutofillHints.username],
                controller: textControllers[1],
                inputType: TextInputType.name,
                hint: LocaleKeys.job,
                spaceAfter: false,
                prefixIcon: Icon(Icons.work),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.job.tr(),
              ),
              TextInput(
                autofillHints: [AutofillHints.email],
                controller: textControllers[2],
                inputType: TextInputType.emailAddress,
                hint: LocaleKeys.mail,
                spaceAfter: false,
                prefixIcon: Icon(Icons.email),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.mail.tr(),
              ),
              15.rh.heightBox,
              RoundedCornerLoadingButton(
                color: kPrimaryColor,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final res = await screenCubit.save(
                        employee, textControllers.map((e) => e.text).toList());
                    logger.i(res);
                    if (res != null) {
                      context.popRoute();
                    }
                  }
                },
                child: LocaleKeys.save.tr().text.white.bold.xl.make(),
              ).wFull(context),
            ],
          ).pSymmetric(h: 16),
        ));
  }
}
