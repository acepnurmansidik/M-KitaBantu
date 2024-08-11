import 'package:flutter/material.dart';
import 'package:kitabantu/theme.dart';

class CustomInputItem extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final EdgeInsets margin;
  final bool showIcon;
  final bool isPassword;

  const CustomInputItem({
    super.key,
    required this.controller,
    required this.hintText,
    required this.margin,
    this.showIcon = false,
    this.isPassword = true,
  });

  @override
  State<CustomInputItem> createState() => _CustomInputItemState();
}

class _CustomInputItemState extends State<CustomInputItem> {
  bool _visiblePassword = true;

  void _toggleIcon() {
    setState(() {
      _visiblePassword = !_visiblePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        controller: widget.controller,
        cursorColor: kBlackColor,
        obscureText: !widget.isPassword ? false : _visiblePassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            right: 45,
            left: 15,
            top: 16,
            bottom: 16,
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: kGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          suffixIcon: widget.showIcon
              ? IconButton(
                  onPressed: _toggleIcon,
                  icon: Icon(_visiblePassword
                      ? Icons.visibility_off
                      : Icons.visibility))
              : const SizedBox(),
        ),
      ),
    );
  }
}
