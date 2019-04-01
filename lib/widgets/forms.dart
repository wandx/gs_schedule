import 'package:flutter/material.dart';
import 'package:gs_schedule/widgets/config.dart' as config;

class CustomTextField extends StatelessWidget {
  final String placeHolder;
  final ValueChanged<String> onChange;
  final bool secure;
  final bool isLongText;

  CustomTextField({
    @required this.placeHolder,
    this.onChange,
    this.secure = false,
    this.isLongText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: config.paddingLeft,
        right: config.paddingRight,
      ),
      margin: EdgeInsets.only(
        bottom: config.marginBottom,
      ),
      child: Container(
        height: isLongText ? config.inputHeight + 50.0 : config.inputHeight,
        padding: EdgeInsets.only(
          left: config.paddingLeft,
          right: config.paddingRight,
        ),
        color: Colors.white.withAlpha(70),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: this.placeHolder,
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            onChanged: onChange,
            obscureText: secure,
            maxLines: isLongText ? 4 : 1,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  SubmitButton({@required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: config.paddingLeft,
        right: config.paddingRight,
      ),
      child: InkWell(
        enableFeedback: true,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(70),
            border: Border.all(
              color: Colors.white.withAlpha(120),
              width: 2.0,
            ),
          ),
          height: config.inputHeight,
          padding: EdgeInsets.only(
            left: 4.0,
            right: 4.0,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
