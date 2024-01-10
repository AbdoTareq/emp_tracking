import 'package:flutter_new_template/core/app_router.dart';
import 'package:flutter_new_template/core/injection_container.dart';
import 'package:flutter_new_template/main.dart';

import '../../export.dart';

GlobalKey<NavigatorState> navKey = sl<AppRouter>().navigatorKey;

// methods
showWarningDialog({String? title = '', String? text = ''}) async {
  await showDialog(
      context: navKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: (title ?? '👍').tr().text.isIntrinsic.bold.xl2.makeCentered(),
          content: (text ?? 'under_dev').tr().text.isIntrinsic.bold.xl.make(),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(yes),
            ),
          ],
        );
      });
}

showSimpleDialog({String title = '', String text = ''}) async {
  await showDialog(
      context: navKey.currentContext!,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: (title.isNotEmpty ? title : '👍')
              .tr()
              .text
              .isIntrinsic
              .bold
              .xl2
              .makeCentered(),
          content: (text.isNotEmpty ? text : 'Success')
              .tr()
              .text
              .isIntrinsic
              .bold
              .xl
              .make(),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(yes),
            ),
          ],
        );
      });
}

showSuccessSnack({String title = '', String text = ''}) {
  // Get.snackbar(
  //     title.isNotEmpty ? title : '👍', text.isNotEmpty ? text : 'under_dev',
  //     snackPosition: SnackPosition.BOTTOM,
  //     duration: Duration(seconds: 6),
  //     backgroundColor: Colors.green,
  //     barBlur: 10,
  //     margin: EdgeInsets.all(10),
  //     padding: EdgeInsets.all(8));
}

showFailSnack({String title = '', String text = '', Function()? yesFunction}) {
  // Get.snackbar(
  //     title.isNotEmpty ? title : watch, text.isNotEmpty ? text : 'under_dev',
  //     snackPosition: SnackPosition.BOTTOM,
  //     duration: Duration(seconds: 15),
  //     barBlur: 10,
  //     mainButton: TextButton(
  //       onPressed: yesFunction,
  //       child: yes.tr().text.isIntrinsic.color(kPrimaryColor).bold.xl.make().p8(),
  //     ),
  //     margin: EdgeInsets.all(10),
  //     padding: EdgeInsets.all(8));
}

Future<Null> handleRequest(Future<Null> Function() asyncFunction,
    {bool showMessage = false, String? message}) async {
  showDialog(
    barrierDismissible: false,
    context: navKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      );
    },
  );
  await handleError(asyncFunction).then((value) {});
}

Future<dynamic> handleError(Future<dynamic> Function() asyncFunction,
    {bool showMessage = false,
    String? message,
    Function(dynamic e)? onError}) async {
  try {
    await asyncFunction();
    Navigator.pop(navKey.currentContext!);
  } catch (e) {
    Navigator.pop(navKey.currentContext!);
    logger.e(e);
    logger.e(StackTrace.current);
    if (onError != null) onError(e);
    if (e.toString().contains('Unauthenticated')) {
      showFailSnack(text: login_to_continue, yesFunction: () {});
    } else {
      List<String> messages =
          e.toString().replaceAll('}', '').split('message:');
      await showWarningDialog(
          title: message ?? 'error',
          text: messages.length > 1 ? messages[1] : messages[0]);
    }
  }
}

Widget? errorLoading(dynamic state) {
  if (state.error != null) {
    return state.error.toString().tr().text.bold.xl.makeCentered().p8();
  }
  if (state.isLoading) {
    return ShimmerList();
  }
  return null;
}

getColorFromHex(String color) =>
    Color(int.parse(color.toString().replaceAll('#', '0xff')));

String getName(item) {
  dynamic temp = item as dynamic;
  try {
    return temp.name;
  } catch (e) {}
  try {
    return temp.title;
  } catch (e) {}
  try {
    return temp.value;
  } catch (e) {}
  try {
    return temp.id;
  } catch (e) {}
  return item.toString();
}

int? getId(item) {
  dynamic temp = item as dynamic;
  try {
    return temp.id;
  } catch (e) {}
  return null;
}

getJson(item) {
  dynamic temp = item as dynamic;
  try {
    return temp.toMap();
  } catch (e) {
    return temp.toJson();
  }
}

// navKey won't work
bool isEn() => MyApp.appContext!.locale.toString().contains('en');
