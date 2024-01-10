import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_template/core/app_router.dart';
import 'package:flutter_new_template/features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:flutter_new_template/generated/codegen_loader.g.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'export.dart';
import 'features/post/presentation/bloc/posts/posts_bloc.dart';
import 'core/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();

  EasyLocalization.logger.enableBuildModes = [];
  await Future.wait([GetStorage.init()]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimaryColor // status bar color
          ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(EasyLocalization(
        assetLoader: CodegenLoader(),
        supportedLocales: [Locale('ar'), Locale('en')],
        path: 'assets/langs',
        fallbackLocale: Locale('en'),
        saveLocale: true,
        child: RequestsInspector(
            child: MyApp(),
            enabled: kDebugMode,
            showInspectorOn: ShowInspectorOn.Both)));
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
              BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
            ],
            child: MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: isDark ? darkTheme : lightTheme,
              debugShowCheckedModeBanner: false,
              routerConfig: di.sl<AppRouter>().config(),
            ),
          );
        });
  }
}
