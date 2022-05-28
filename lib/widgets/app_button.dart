import 'package:flutter/material.dart';
import 'package:news_app/utils/color.dart';
import '../../utils/text.dart';

class AppButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final bool showBoxShadow;
  final bool showBorder;
  final Color textColor;
  final Function()? onTap;
  final bool isDisabled;
  const AppButton(
      {Key? key,
      required this.title,
      this.backgroundColor = kSecondaryColor,
      this.showBorder = false,
      this.textColor = Colors.white,
      this.onTap,
      this.showBoxShadow = false,
      this.height = 50,
      this.isDisabled = false,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isDisabled) {
          onTap?.call();
        }
      },
      child: Container(
        clipBehavior: Clip.none,
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isDisabled ? Colors.grey : backgroundColor,
              blurRadius: 5,
              spreadRadius: -5,
              offset: showBoxShadow ? const Offset(0, 7) : Offset.zero,
            )
          ],
          color: isDisabled ? Colors.grey : backgroundColor,
          border: showBorder
              ? Border.all(
                  color: backgroundColor,
                  width: 1.0,
                  style: BorderStyle.solid,
                )
              : const Border.fromBorderSide(BorderSide.none),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: AppText.headingMeduim(
            title,
            color: isDisabled ? Colors.grey.shade300 : textColor,
          ),
        ),
      ),
    );
  }
}
