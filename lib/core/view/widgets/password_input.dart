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
      spaceAfter: false,
      prefixIcon: Icon(Icons.lock, color: borderColor),
      isPass: true,
      maxLines: 1,
      validate: validate ?? (value) => value!.length > 5 ? null : passWar,
    );
  }
}
