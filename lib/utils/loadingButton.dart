import 'package:flutter/material.dart';
import 'package:todo/colors.dart';
import 'package:todo/fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton(
      {Key? key,
      this.onPressed,
      this.text,
      this.fontSize = 18,
      required this.color})
      : super(key: key);
  final String? text;
  final Future<dynamic> Function()? onPressed;
  final double fontSize;
  final Color color;
  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: AnimatedSwitcher(
        switchInCurve: Curves.easeOutCubic,
        duration: const Duration(milliseconds: 300),
        child: !loading
            ? FittedBox(
                child: Text(
                  widget.text!,
                  style: bodyText.copyWith(
                      fontSize: widget.fontSize, color: Colors.white),
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    visible: false,
                    child: FittedBox(
                      child: Text(
                        widget.text!,
                        style: bodyText.copyWith(
                          letterSpacing: 0.6,
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 3),
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
      ),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        minimumSize: Size(double.infinity, 0),
        primary: Colors.black,
        backgroundColor: !loading ? widget.color : widget.color.withAlpha(255),
      ),
      onPressed: !loading
          ? () {
              setState(() {
                loading = true;
              });
              widget.onPressed!().then((value) {
                setState(() {
                  loading = false;
                });
              });
            }
          : null,
    );
  }
}
