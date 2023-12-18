import 'package:flutter_new_template/export.dart';
import 'package:lottie/lottie.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/no_internet.json',
              width: 200,
              repeat: false,
              onLoaded: (composition) {},
            ),
            'no_internet_connection'.tr().text.bold.xl.make().p8(),
          ],
        ),
      ),
    );
  }
}
