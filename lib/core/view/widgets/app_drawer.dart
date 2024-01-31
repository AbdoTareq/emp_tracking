import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../export.dart';
import '../../app_router.dart';

class AppDrawer extends HookWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isEN = useState(context.locale.toString().contains('en'));
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            onTap: () {
              Navigator.pop(context);
              context.pushRoute(MaterialsRoute());
            },
            title: 'materials'
                .tr()
                .text
                .color(Theme.of(context).primaryColor)
                .bold
                .xl
                .make(),
            leading: const Icon(Icons.person, color: kPrimaryColor),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              context.pushRoute(ClientRoute());
            },
            title: 'clients'
                .tr()
                .text
                .color(Theme.of(context).primaryColor)
                .bold
                .xl
                .make(),
            leading: const Icon(Icons.person, color: kPrimaryColor),
          ),
          // SwitchListTile(
          //     title: darkMode.tr().text.bold.make(),
          //     value: controller.darkMode.value,
          //     secondary: Icon(Icons.sunny, color: kPrimaryColor),
          //     onChanged: (_) {
          //       controller.darkMode.toggle();
          //       controller.box.write('dark', controller.darkMode.value);
          //     }),
          SwitchListTile(
              title: LocaleKeys.language.tr().text.bold.make(),
              value: isEN.value,
              secondary: const Icon(Icons.language, color: kPrimaryColor),
              onChanged: (_) async {
                isEN.value = !isEN.value;
                await context.setLocale(Locale(
                    context.locale.toString().contains('en') ? 'ar' : 'en'));
              }),
          GetStorage().hasData('token')
              ? ListTile(
                  onTap: () {
                    GetStorage().remove('token');
                    // Get.find<AppSettingsController>().user.value.data = null;
                  },
                  title: LocaleKeys.logout
                      .tr()
                      .text
                      .color(Theme.of(context).primaryColor)
                      .bold
                      .xl
                      .make()
                      .p8(),
                  leading: const Icon(Icons.exit_to_app, color: kPrimaryColor),
                ).w48(context)
              : ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: LocaleKeys.login
                      .tr()
                      .text
                      .color(Theme.of(context).primaryColor)
                      .bold
                      .xl
                      .make()
                      .p8(),
                  leading: const Icon(Icons.login, color: kPrimaryColor),
                ).w48(context),
        ],
      ).centered(),
    );
  }
}
