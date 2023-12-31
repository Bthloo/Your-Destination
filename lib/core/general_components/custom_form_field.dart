import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);
typedef OnChange = void Function(String?);
typedef OnTap = void Function();

class CustomFormField extends StatelessWidget {
  String hintText;
  MyValidator validator;
  OnChange? onChange;
  OnTap? onTab;
  TextEditingController controller;
  TextInputType keyboardType;
  IconButton? suffix;
  Widget? prefix;
  bool isPassword;
  FocusNode? passwordFocusNode;
  CustomFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.controller,
      this.prefix,
      this.keyboardType = TextInputType.text,
      this.suffix,
      this.isPassword = false,
      this.passwordFocusNode,
        this.onChange,
        this.onTab
      });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      controller: controller,
      onTap: onTab,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isPassword,
      focusNode: passwordFocusNode,
      onChanged: onChange,
      //textDirection: TextDirection,
      style: const TextStyle(color: Color(0xffEDEDED)),
      decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: prefix,
          //labelText: 'Email',
          labelText: hintText,
          //suffixIcon: ,
          labelStyle: const TextStyle(color: Color(0xffEDEDED)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          fillColor: const Color(0xff444444),
          filled: true),
    );
  }
}
