import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownButtonFormFieldCustom extends StatefulWidget {
  final Map items;
  final String hint;
  final Function onSave;
  final fieldValue;
  final String? error;
  final bool isCompulsory;
  DropDownButtonFormFieldCustom({Key? key,
    required this.hint,
    required this.items,
    required this.onSave,
    required this.fieldValue,
    this.isCompulsory = true,
    this.error = "Vui lòng chọn thông tin"
  }) : super(key: key);

  @override
  State<DropDownButtonFormFieldCustom> createState() => _DropDownButtonFormFieldCustomState();
}

class _DropDownButtonFormFieldCustomState extends State<DropDownButtonFormFieldCustom> {

  @override
  Widget build(BuildContext context) {
     if(widget.fieldValue != null) {
       return DropdownButtonFormField(
         value: widget.fieldValue,
         validator: (value) {
           if (widget.isCompulsory == false) return null;
           if (value == null) {
             return widget.error;
           }
           return null;
         },
         decoration: InputDecoration(
           border: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(5.r)),
               borderSide: const BorderSide(color: Colors.black)
           ),
         ),
         hint: Text(widget.hint),
         items: widget.items.entries.map((entry) {
           return DropdownMenuItem(value: entry.key, child: Text(entry.value),);
         }).toList(),
         onChanged: (value) {
         },
         onSaved: (value) {
           if (value == null) return;
             widget.onSave(value);
           //print("Save DropDown Fied" + value.toString());
         },
       );
     }
     else {
       return DropdownButtonFormField(
         validator: (value) {
           if (widget.isCompulsory == false) return null;
           if (value == null) {
             return widget.error;
           }
           return null;
         },
         decoration: InputDecoration(
           border: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(5.r)),
               borderSide: const BorderSide(color: Colors.black)
           ),
         ),
         hint: Text(widget.hint),
         items: widget.items.entries.map((entry) {
           return DropdownMenuItem(value: entry.key, child: Text(entry.value),);
         }).toList(),
         onChanged: (value) {
         },
         onSaved: (value) {
           if (value == null) return;
             widget.onSave(value);
           //print("Save DropDown Fied" + value.toString());
         },
       );
     }
  }
}

