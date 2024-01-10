import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_new_template/features/auth/presentation/cubit/auth_cubit.dart';

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
            borderColor: Colors.white,
            inputType: TextInputType.emailAddress,
            hint: mail,
            prefixIcon: Icon(Icons.email, color: Colors.white),
            validate: (value) => value!.isNotEmpty ? null : mail.tr(),
          ),
          20.heightBox,
          PasswordInput(
            controller: passTextController,
            hint: pass,
          ),
          forgetPass
              .tr()
              .text
              .end
              .white
              .bold
              .make()
              .p2()
              .wFull(context)
              .onTap(() {
            // Get.toNamed(Routes.RESET_PASS);
          }),
          20.heightBox,
          RoundedCornerLoadingButton(
            color: kSecondaryColor,
            onPressed: () async => await controller.login({
              "email": mailTextController.text,
              "password": passTextController.text,
            }),
            child: login.tr().text.white.bold.xl.make().p8(),
          ).wFull(context),
          20.heightBox,
          // ? make it Get.off instead of to solve GlobalKey duplicate  problem
          dontHaveAccount.tr().text.white.bold.makeCentered().p2().onTap(() {
            // Get.toNamed(Routes.SIGNUP);
          }),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}
