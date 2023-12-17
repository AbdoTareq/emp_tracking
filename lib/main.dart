import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app_bindings.dart';
import 'constants.dart';
import 'utils/langs/my_translation.dart';
import 'package:requests_inspector/requests_inspector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([GetStorage.init()]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimaryColor // status bar color
          ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(RequestsInspector(child: MyApp(), enabled: kDebugMode));
  });
}

class MyApp extends StatelessWidget {
  final bool language = GetStorage().read('language') ?? true;
  final bool isDark = GetStorage().read('dark') ?? false;
  static BuildContext? appContext;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(baseWidth, baseHeight),
        minTextAdapt: true,
        rebuildFactor: RebuildFactors.all,
        builder: (BuildContext context, Widget? child) {
          appContext = context;
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            translations: MyTranslation(),
            theme: isDark ? darkTheme : lightTheme,
            enableLog: false,
            locale: language ? Locale('en', 'US') : Locale('ar', 'EG'),
            initialBinding: AppBinding(),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        });
  }
}
