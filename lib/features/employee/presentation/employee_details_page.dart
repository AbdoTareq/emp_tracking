import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/feature/data/models/employee_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/view/widgets/rounded_corner_loading_button.dart';
import '../../../export.dart';
import 'employee_cubit.dart';

@RoutePage()
class EmployeeDetailsPage extends HookWidget {
  final screenCubit = sl<EmployeeCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();
  final EmployeeModel? employee;
  EmployeeDetailsPage({super.key, this.employee});

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
        appBar: const CustomAppBar(title: LocaleKeys.save),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomListTile(
                onTap: () async => await Clipboard.setData(
                    ClipboardData(text: employee?.id ?? '')),
                title: employee?.id.toString().text.make(),
                trailing: const Icon(Icons.copy),
              ),
              TextInput(
                autofillHints: const [AutofillHints.username],
                controller: textControllers[0],
                inputType: TextInputType.name,
                hint: LocaleKeys.name,
                spaceAfter: false,
                prefixIcon: const Icon(Icons.person),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.name.tr(),
              ),
              TextInput(
                autofillHints: const [AutofillHints.username],
                controller: textControllers[1],
                inputType: TextInputType.name,
                hint: LocaleKeys.job,
                spaceAfter: false,
                prefixIcon: const Icon(Icons.work),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.job.tr(),
              ),
              TextInput(
                autofillHints: const [AutofillHints.email],
                controller: textControllers[2],
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
