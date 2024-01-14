import 'package:flutter/material.dart';
import 'package:flutter_new_template/core/extensions/num_extension.dart';

class RoundedCornerLoadingButton extends StatefulWidget {
  const RoundedCornerLoadingButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.isOutlined = false,
    this.borderColor,
    this.height,
    this.width,
  }) : super(key: key);

  final Function() onPressed;
  final Color? color;
  final Color? borderColor;
  final Widget child;
  final bool isOutlined;
  final double? height;
  final double? width;

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
                minimumSize: MaterialStateProperty.all(
                    Size(widget.width ?? 0, (widget.height ?? 58).rh)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                )))
            : ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                    Size(widget.width ?? 0, (widget.height ?? 58).rh)),
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
