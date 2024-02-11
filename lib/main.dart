import 'core/app_router.dart';
import 'firebase_options.dart';
import 'generated/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';

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
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor // status bar color
      ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
          assetLoader: const CodegenLoader(),
          supportedLocales: const [Locale('ar'), Locale('en')],
          path: 'assets/langs',
          fallbackLocale: const Locale('en'),
          saveLocale: true,
          child: const MyApp()),
    );
  });
}

class MyApp extends StatelessWidget {
  static bool isDark = GetStorage().read('dark') ?? false;
  static BuildContext? appContext;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return ScreenUtilInit(
        designSize: const Size(baseWidth, baseHeight),
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
