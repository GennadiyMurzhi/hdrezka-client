import 'package:flutter/material.dart';

class CustomTextEditingController extends TextEditingController{
  @override
  set text(String newText){

    final int? length = newText.length;
    value = value.copyWith(
      text: newText,
      selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
      composing: TextRange.empty,
    );
  }


}