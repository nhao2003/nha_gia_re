import 'package:flutter/material.dart';

class TextFormCustom extends StatelessWidget {
  final String hint;
  final String label;
  final String error;
  String fieldValue;
  Function(String?) onSave;
  Function(String?)? onValidate;
  final TextInputType keyBoardType;
  TextFormCustom(
      {Key? key,
      required this.label,
      required this.hint,
      this.error = "Bạn chưa nhập thông tin",
      this.keyBoardType = TextInputType.text,
      required this.onSave,
      this.onValidate,
      this.fieldValue = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: fieldValue,
      keyboardType: keyBoardType,
      validator: (value) {
        if (hint.contains("(Không bắt buộc)")) {
          if (value == null || value.isEmpty) {
            return null;
          } else {
            if (onValidate != null) {
              return onValidate!(value);
            }
          }
          return null;
        } else {
          if (value == null || value.isEmpty) {
            return error;
          } else {
            if (onValidate != null) {
              return onValidate!(value);
            }
          }
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onSaved: (value) {
        //if(value == null || value.isEmpty) return;
        onSave(value);
      },
    );
  }
}
