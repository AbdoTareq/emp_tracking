import 'package:flutter/material.dart';

class RoundedCornerLoadingButton extends StatefulWidget {
  const RoundedCornerLoadingButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.isOutlined = false,
    this.borderColor,
  }) : super(key: key);

  final Function() onPressed;
  final Color? color;
  final Color? borderColor;
  final Widget child;
  final bool isOutlined;

  @override
  State<RoundedCornerLoadingButton> createState() =>
      _RoundedCornerLoadingButtonState();
}

class _RoundedCornerLoadingButtonState
    extends State<RoundedCornerLoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: widget.isOutlined
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                )))
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    widget.color ?? Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ))),
        onPressed: isLoading
            ? null
            : () async {
                if (mounted) {
                  setState(() {
                    isLoading = true;
                  });
                }
                await widget.onPressed();
                if (mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : widget.child);
  }
}
