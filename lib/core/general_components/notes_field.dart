import 'package:flutter/material.dart';
typedef MyValidator = String? Function(String?);
class NotesFormField extends StatelessWidget {
 final String? hintText ;
 final MyValidator validator;
 final TextEditingController controller;
 final bool expands;
 final int? maxline;
 final int? minline;
  const NotesFormField({super.key, required this.hintText,required this.validator,required this.controller,this.expands=true,this.maxline=null,this.minline=null});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.top,
      expands: expands,
      maxLines: maxline,
      minLines: minline,
      controller: controller,

      validator: validator,
      style: const TextStyle(
        height: 1.5,
          color: Color(0xffEDEDED)
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15)
        ),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color(0xffEDEDED)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          fillColor:const Color(0xff444444),
          filled: true
      ),
    );
  }
}
