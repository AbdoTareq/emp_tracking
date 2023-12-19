import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_template/features/post/post_cubit.dart';
import 'package:flutter_new_template/core/routes/routes.dart';
import 'package:flutter_new_template/gen/codegen_loader.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
        child: RequestsInspector(child: Root(), enabled: kDebugMode)));
  });
}

class Root extends StatelessWidget {
  static bool isDark = GetStorage().read('dark') ?? false;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(baseWidth, baseHeight),
        minTextAdapt: true,
        rebuildFactor: RebuildFactors.all,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<PostCubit>(
                create: (BuildContext context) => PostCubit(),
              ),
            ],
            child: MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: isDark ? darkTheme : lightTheme,
              debugShowCheckedModeBanner: false,
              routerConfig: routes,
            ),
          );
        });
  }
}
