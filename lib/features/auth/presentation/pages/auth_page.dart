import 'package:auto_route/auto_route.dart';
import '../../../../core/app_router.dart';
import '../cubit/auth_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/view/widgets/rounded_corner_loading_button.dart';
import '../../../../export.dart';

@RoutePage()
class AuthPage extends HookWidget {
  AuthPage({Key? key}) : super(key: key);
  final controller = sl<AuthCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mailTextController = useTextEditingController();
    final passTextController = useTextEditingController();
    return Scaffold(
        body: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            autofillHints: const [AutofillHints.email],
            controller: mailTextController,
            inputType: TextInputType.emailAddress,
            hint: LocaleKeys.mail,
            spaceAfter: false,
            prefixIcon: const Icon(Icons.email),
            validate: (value) =>
                value!.isNotEmpty ? null : LocaleKeys.mail.tr(),
          ),
          PasswordInput(
            controller: passTextController,
            hint: LocaleKeys.pass,
          ),
          15.rh.heightBox,
          RoundedCornerLoadingButton(
            color: kPrimaryColor,
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              final res = await controller.login(
                mailTextController.text,
                passTextController.text,
              );
              logger.i(res);
              // if (res != null) {
              //   context.replaceRoute(EmployeeRoute());
              // }
            },
            child: LocaleKeys.login.tr().text.white.bold.xl.make(),
          ).wFull(context),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}
