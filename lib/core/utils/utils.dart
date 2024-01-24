import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_management/core/app_router.dart';
import 'package:employee_management/main.dart';

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
              child: Text(LocaleKeys.yes),
            ),
          ],
        );
      });
}

showSimpleDialog({dynamic title = '', dynamic text = ''}) async {
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
          title: (title.toString().isNotEmpty ? title.toString() : '👍')
              .tr()
              .text
              .isIntrinsic
              .bold
              .xl2
              .makeCentered(),
          content: (text.toString().isNotEmpty ? text.toString() : 'Success')
              .tr()
              .text
              .isIntrinsic
              .bold
              .xl
              .make(),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocaleKeys.yes),
            ),
          ],
        );
      });
}

showSuccessSnack({String title = '', String text = ''}) {
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(text, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
    ),
  );
}

showFailSnack({String title = '', String text = '', Function()? yesFunction}) {
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(text, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.redAccent,
    ),
  );
}

Future<Null> handleRequest(Future Function() asyncFunction,
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
    final res = await asyncFunction();
    Navigator.pop(navKey.currentContext!);
    return res;
  } catch (e) {
    Navigator.pop(navKey.currentContext!);
    logger.e(e);
    logger.e(StackTrace.current);
    if (onError != null) onError(e);
    if (e.toString().contains('Unauthenticated')) {
      showFailSnack(text: LocaleKeys.login_to_continue, yesFunction: () {});
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

getModel(item, map) {
  dynamic temp = item as dynamic;
  if (map is Map) {
    return map;
  }
  try {
    return temp.fromMap(map);
  } catch (e) {
    return temp.fromJson(map);
  }
}

// navKey won't work
bool isEn() => MyApp.appContext!.locale.toString().contains('en');

/// T must has data model with a factory constructor fromMap or fromJson
Stream<List<T>> transformStream<T>(
    Stream<QuerySnapshot<Map<String, dynamic>>> inputStream, dynamic item) {
  return inputStream.map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    // Extract the list of documents from the QuerySnapshot
    List<T> itemList =
        querySnapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
      return (getModel(item, {...doc.data()!, 'id': doc.id}) as T);
    }).toList();

    // Emit the list as a new stream
    return itemList;
  });
}

/// T must has data model with a factory constructor fromMap or fromJson
Stream<List<T>> transformStreamFromMapToModel<T>(
    Stream<List<Map<String, dynamic>>> inputStream, dynamic item) {
  return inputStream.map((List<Map<String, dynamic>> querySnapshot) {
    // Extract the list of documents from the QuerySnapshot
    List<T> itemList = querySnapshot.map((Map<String, dynamic> doc) {
      return (getModel(item, doc) as T);
    }).toList();
    // Emit the list as a new stream
    return itemList;
  });
}
