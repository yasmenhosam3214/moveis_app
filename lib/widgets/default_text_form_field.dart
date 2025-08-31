import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moveis_app/app_theme.dart';

class DefaultTextFormField extends StatelessWidget {
  String hintText;
  TextEditingController ? controller;
  void Function(String)? onChanged;
  String ? prefixIconImageName;

  DefaultTextFormField({

    required this.hintText,
     this.controller,
     this.onChanged,
    this.prefixIconImageName
});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:  onChanged,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.gray,
        hintText: hintText,
        prefixIcon: SvgPicture.asset('assets/icons/$prefixIconImageName.svg',
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),
      ),


    );
  }
}
