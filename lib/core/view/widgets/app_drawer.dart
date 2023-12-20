import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../export.dart';

class AppDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isEN = useState(context.locale.toString().contains('en'));
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SwitchListTile(
          //     title: darkMode.tr().text.bold.make(),
          //     value: controller.darkMode.value,
          //     secondary: Icon(Icons.sunny, color: kPrimaryColor),
          //     onChanged: (_) {
          //       controller.darkMode.toggle();
          //       controller.box.write('dark', controller.darkMode.value);
          //     }),
          SwitchListTile(
              title: language.tr().text.bold.make(),
              value: isEN.value,
              secondary: Icon(Icons.language, color: kPrimaryColor),
              onChanged: (_) async {
                isEN.value = !isEN.value;
                await context.setLocale(Locale(
                    context.locale.toString().contains('en') ? 'ar' : 'en'));
              }),
          GetStorage().hasData('token')
              ? CustomListTile(
                  onTap: () {
                    GetStorage().remove('token');
                    // Get.find<AppSettingsController>().user.value.data = null;
                  },
                  title: logout
                      .tr()
                      .text
                      .color(Theme.of(context).primaryColor)
                      .bold
                      .xl
                      .make()
                      .p8(),
                  leading: Icon(Icons.exit_to_app, color: kPrimaryColor),
                ).w48(context)
              : CustomListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: login
                      .tr()
                      .text
                      .color(Theme.of(context).primaryColor)
                      .bold
                      .xl
                      .make()
                      .p8(),
                  leading: Icon(Icons.login, color: kPrimaryColor),
                ).w48(context),
        ],
      ).centered(),
    );
  }
}
