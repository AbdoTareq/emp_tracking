import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/app_router.dart';
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
            spaceAfter: false,
            prefixIcon: Icon(Icons.email),
            validate: (value) => value!.isNotEmpty ? null : mail.tr(),
          ),
          PasswordInput(
            controller: passTextController,
            hint: pass,
          ),
          15.rh.heightBox,
          RoundedCornerLoadingButton(
            color: kPrimaryColor,
            onPressed: () async {
              final res = await controller.login(
                mailTextController.text,
                passTextController.text,
              );
              logger.i(res);
              if (res != null) {
                context.navigateNamedTo(PostsRoute.name);
              }
            },
            child: login.tr().text.white.bold.xl.make(),
          ).wFull(context),
        ],
      ).pSymmetric(h: 16),
    ));
  }
}
