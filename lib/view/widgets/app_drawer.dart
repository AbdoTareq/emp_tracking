import 'package:flutter_hooks/flutter_hooks.dart';
import '../../export.dart';

class AppDrawer extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SwitchListTile(
          //     title: darkMode.text.bold.make(),
          //     value: controller.darkMode.value,
          //     secondary: Icon(Icons.sunny, color: kPrimaryColor),
          //     onChanged: (_) {
          //       controller.darkMode.toggle();
          //       controller.box.write('dark', controller.darkMode.value);
          //     }),
          // SwitchListTile(
          //     title: language.text.bold.make(),
          //     value: controller.lang.value,
          //     secondary: Icon(Icons.language, color: kPrimaryColor),
          //     onChanged: (_) {
          //       controller.lang.toggle();
          //       controller.box.write('language', controller.lang.value);
          //     }),
          GetStorage().hasData('token')
              ? CustomListTile(
                  onTap: () {
                    GetStorage().remove('token');
                    // Get.find<AppSettingsController>().user.value.data = null;
                  },
                  title: logout.text
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
                  title: login.text
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
