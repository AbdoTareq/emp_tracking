import '../../../export.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key? key,
    required this.controller,
    required this.hint,
    this.validate,
    this.isUnderline = true,
    this.borderColor,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final bool showPass = false;
  final bool isUnderline;
  final String? Function(String?)? validate;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextInput(
      borderColor: borderColor,
      controller: controller,
      autofillHints: [AutofillHints.password],
      hint: hint,
      showUnderline: isUnderline,
      suffixIcon: StatefulBuilder(builder: (context, setState) {
        return Icon(!showPass ? Icons.visibility : Icons.visibility_off,
                color: borderColor)
            .onTap(() {
          showPass.toggle();
          setState() {}
        });
      }),
      prefixIcon: Icon(Icons.lock, color: borderColor),
      isPass: showPass,
      validate: validate ?? (value) => value!.length > 5 ? null : passWar,
    );
  }
}
