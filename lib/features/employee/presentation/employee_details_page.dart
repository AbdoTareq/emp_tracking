import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/view/widgets/rounded_corner_loading_button.dart';
import 'package:employee_management/export.dart';
import 'package:employee_management/features/employee/presentation/employee_cubit.dart';
import 'package:employee_management/features/employee/presentation/employee_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class EmployeeDetailsPage extends HookWidget {
  final screenCubit = sl<EmployeeCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textControllers =
        List.generate(6, (index) => useTextEditingController());
    logger.i(sl<FirebaseAuth>().currentUser!.uid);
    return Scaffold(
        body: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            autofillHints: [AutofillHints.username],
            controller: textControllers[0],
            inputType: TextInputType.name,
            hint: name,
            spaceAfter: false,
            prefixIcon: Icon(Icons.person),
            validate: (value) => value!.isNotEmpty ? null : name.tr(),
          ),
          TextInput(
            autofillHints: [AutofillHints.username],
            controller: textControllers[1],
            inputType: TextInputType.name,
            hint: job,
            spaceAfter: false,
            prefixIcon: Icon(Icons.work),
            validate: (value) => value!.isNotEmpty ? null : job.tr(),
          ),
          TextInput(
            autofillHints: [AutofillHints.email],
            controller: textControllers[2],
            inputType: TextInputType.emailAddress,
            hint: mail,
            spaceAfter: false,
            prefixIcon: Icon(Icons.email),
            validate: (value) => value!.isNotEmpty ? null : mail.tr(),
          ),
          15.rh.heightBox,
          RoundedCornerLoadingButton(
            color: kPrimaryColor,
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final res = await screenCubit
                    .create(textControllers.map((e) => e.text).toList());
                logger.i(res);
                if (res != null) {
                  context.popRoute();
                }
              }
            },
            child: save.tr().text.white.bold.xl.make(),
          ).wFull(context),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}