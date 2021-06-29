import 'package:ccxgui/utils/constants.dart';
import 'package:ccxgui/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//TODO: warp lines properly
class CustomTextField extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onEditingComplete;
  final TextEditingController controller;
  final bool intOnly;
  final bool enabled;

  const CustomTextField({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onEditingComplete,
    required this.controller,
    this.intOnly = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Container(
            color: kBgLightColor,
            width: Responsive.isDesktop(context) ? 300 : 100,
            child: TextFormField(
              cursorHeight: 25,
              enabled: enabled,
              inputFormatters:
                  intOnly ? [FilteringTextInputFormatter.digitsOnly] : [],
              onEditingComplete: () => onEditingComplete(),
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 6,
                ),
                isDense: true,
              ),
              cursorColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
