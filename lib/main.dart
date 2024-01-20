import 'package:employee_management/core/app_router.dart';
import 'package:employee_management/firebase_options.dart';
import 'package:employee_management/generated/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await di.init();

  EasyLocalization.logger.enableBuildModes = [];
  await Future.wait([GetStorage.init()]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimaryColor // status bar color
          ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
          assetLoader: CodegenLoader(),
          supportedLocales: [Locale('ar'), Locale('en')],
          path: 'assets/langs',
          fallbackLocale: Locale('en'),
          saveLocale: true,
          child: MyApp()),
    );
  });
}

class MyApp extends StatelessWidget {
  static bool isDark = GetStorage().read('dark') ?? false;
  static BuildContext? appContext;

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ScreenUtilInit(
        designSize: Size(baseWidth, baseHeight),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: isDark ? darkTheme : lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: di.sl<AppRouter>().config(),
          );
        });
  }
}
