import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class DropDownButtonFormFieldCustom extends StatefulWidget {
  final List<String> items;
  final String hint;
  final Function(String) onSave;
  String fieldValue;
  final String? error;
  DropDownButtonFormFieldCustom(
      {Key? key,
      required this.hint,
      required this.items,
      required this.onSave,
      this.fieldValue = "",
      this.error = "Vui lòng chọn thông tin"})
      : super(key: key);

  @override
  State<DropDownButtonFormFieldCustom> createState() =>
      _DropDownButtonFormFieldCustomState();
}

class _DropDownButtonFormFieldCustomState
    extends State<DropDownButtonFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.indexOf(widget.fieldValue) > 0) {
      return DropdownButtonFormField(
        value: widget.fieldValue,
        validator: (value) {
          if (widget.hint.contains("Không bắt buộc")) return null;
          if (value == null || value.isEmpty) {
            return widget.error;
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
              borderSide: const BorderSide(color: Colors.black)),
        ),
        hint: Text(widget.hint),
        items: widget.items.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          print(value);
        },
        onSaved: (value) {
          if (value == null || value.isEmpty) return;
          widget.onSave(value);
          print("Save DropDown Fied" + value.toString());
        },
      );
    } else {
      return DropdownButtonFormField(
        validator: (value) {
          if (widget.hint.contains("Không bắt buộc")) return null;
          if (value == null || value.isEmpty) {
            return widget.error;
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.r)),
              borderSide: const BorderSide(color: Colors.black)),
        ),
        hint: Text(widget.hint),
        items: widget.items.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          print(value);
        },
        onSaved: (value) {
          if (value == null || value.isEmpty) return;
          widget.onSave(value);
          print("Save DropDown Fied" + value.toString());
        },
      );
    }
  }
}
