import 'package:employee_management/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/view/widgets/rounded_corner_loading_button.dart';
import '../../../../export.dart';

@RoutePage()
class AuthPage extends HookWidget {
  AuthPage({Key? key}) : super(key: key);
  final controller = sl<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    final mailTextController = useTextEditingController();
    final passTextController = useTextEditingController();
    return Scaffold(
        body: Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            autofillHints: [AutofillHints.email],
            controller: mailTextController,
            inputType: TextInputType.emailAddress,
            hint: mail,
            prefixIcon: Icon(Icons.email),
            validate: (value) => value!.isNotEmpty ? null : mail.tr(),
          ),
          20.heightBox,
          PasswordInput(
            controller: passTextController,
            hint: pass,
          ),
          forgetPass.tr().text.end.bold.make().p2().wFull(context).onTap(() {
            // Get.toNamed(Routes.RESET_PASS);
          }),
          20.heightBox,
          RoundedCornerLoadingButton(
            color: kPrimaryColor,
            onPressed: () async => await controller.login({
              "email": mailTextController.text,
              "password": passTextController.text,
            }),
            child: login.tr().text.white.bold.xl.make(),
          ).wFull(context),
          20.heightBox,
          // ? make it Get.off instead of to solve GlobalKey duplicate  problem
          dontHaveAccount.tr().text.bold.makeCentered().p2().onTap(() {
            // Get.toNamed(Routes.SIGNUP);
          }),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}
