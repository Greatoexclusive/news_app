import 'package:flutter/material.dart';
import 'package:news_app/utils/text.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {Key? key,
      required this.title,
      this.icon,
      required this.onTap,
      required this.isDisabled})
      : super(key: key);

  final String title;
  final IconData? icon;
  final Function()? onTap;
  bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: AppText.heading(title),
          ),
          isDisabled == false
              ? GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : Center()
        ],
      ),
    );
  }
}
