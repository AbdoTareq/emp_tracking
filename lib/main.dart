import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_template/app/post/post_cubit.dart';
import 'package:flutter_new_template/app/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([GetStorage.init()]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimaryColor // status bar color
          ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(RequestsInspector(child: Root(), enabled: kDebugMode));
  });
}

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class Root extends StatelessWidget {
  static bool isEn = GetStorage().read('language') ?? true;
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
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: isDark ? darkTheme : lightTheme,
              locale: isEn ? Locale('en', 'US') : Locale('ar', 'EG'),
              routerConfig: routes,
            ),
          );
        });
  }
}
