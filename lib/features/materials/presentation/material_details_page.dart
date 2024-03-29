import 'package:auto_route/auto_route.dart';
import 'package:employee_management/core/view/widgets/rounded_corner_loading_button.dart';
import 'package:employee_management/export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/models/material_model.dart';
import 'material_cubit.dart';

@RoutePage()
class MaterialDetailsPage extends HookWidget {
  final screenCubit = sl<MaterialCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();
  final MaterialModel? item;
  MaterialDetailsPage({this.item});

  String? getRightField(int index, MaterialModel? item) {
    switch (index) {
      case 0:
        return item?.name;
      case 1:
        return item?.description;
      case 2:
        return item?.stock.toString();
      default:
        return item?.used.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> textControllers = List.generate(5,
        (index) => useTextEditingController(text: getRightField(index, item)));
    return Scaffold(
        appBar: CustomAppBar(title: LocaleKeys.save),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextInput(
                autofillHints: [AutofillHints.username],
                controller: textControllers[0],
                inputType: TextInputType.name,
                hint: LocaleKeys.name,
                spaceAfter: false,
                prefixIcon: Icon(Icons.person),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.name.tr(),
              ),
              TextInput(
                autofillHints: [AutofillHints.name],
                controller: textControllers[1],
                inputType: TextInputType.name,
                hint: LocaleKeys.description,
                spaceAfter: false,
                prefixIcon: Icon(Icons.description),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.description.tr(),
              ),
              TextInput(
                controller: textControllers[2],
                inputType: TextInputType.number,
                hint: LocaleKeys.stock,
                spaceAfter: false,
                prefixIcon: Icon(Icons.calculate),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.stock.tr(),
              ),
              TextInput(
                controller: textControllers[3],
                inputType: TextInputType.number,
                hint: LocaleKeys.used,
                spaceAfter: false,
                prefixIcon: Icon(Icons.calculate),
                validate: (value) =>
                    value!.isNotEmpty ? null : LocaleKeys.used.tr(),
              ),
              15.rh.heightBox,
              RoundedCornerLoadingButton(
                color: kPrimaryColor,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final res = await screenCubit.save(
                        item, textControllers.map((e) => e.text).toList());
                    logger.i(res);
                    if (res != null) {
                      context.popRoute();
                    }
                  }
                },
                child: LocaleKeys.save.tr().text.white.bold.xl.make(),
              ).wFull(context),
            ],
          ).pSymmetric(h: 16),
        ));
  }
}
