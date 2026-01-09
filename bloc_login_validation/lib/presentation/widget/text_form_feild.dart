import 'package:bloc_login_validation/core/util/color_pallet.dart';
import 'package:flutter/material.dart';

class ReusableTextFormFeild extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isShow;
  final String hint;
  final bool isTagFiled;
  final int? maxLine;
  final String? Function(String?)? validchecker;
  final void Function()? addTag;
  final void Function(String)? onSubmit;
  const ReusableTextFormFeild({
    super.key,
    required this.controller,
    required this.inputType,
    required this.inputAction,
    required this.isShow,
    required this.hint,
    required this.isTagFiled,
    this.maxLine,
    this.validchecker,
    this.addTag,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmit,
      validator: validchecker,
      maxLines: maxLine,
      cursorColor: secondorywhite,
      controller: controller,
      textInputAction: inputAction,
      keyboardType: inputType,
      obscureText: isShow,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        suffixIcon:
            isTagFiled
                ? IconButton(
                  onPressed: addTag,
                  icon:  Icon(Icons.add, color:secondorywhite),
                )
                : const SizedBox(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        hintText: hint,
        hintStyle:TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        border: formFieldBorder(secondorywhite),
        focusedBorder: formFieldBorder(secondorywhite),
        errorBorder: formFieldBorder(errorColor),
        enabledBorder: formFieldBorder(secondorywhite),
      ),
    );
  }

  OutlineInputBorder formFieldBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: borderColor, width: 2),
    );
  }
}
