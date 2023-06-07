import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/text_styles.dart';
class CheckFormField extends StatefulWidget {
  final String name;
  final Function(bool) onChange;
  bool initialValue;
   CheckFormField({Key? key, required this.name, required this.onChange, this.initialValue = false}) : super(key: key);

  @override
  State<CheckFormField> createState() => _CheckFormFieldState();
}

class _CheckFormFieldState extends State<CheckFormField> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Checkbox(checkColor: Colors.indigo,
              onChanged: (valueChange){
            setState(() {
              widget.initialValue = valueChange ?? false;
            });
            widget.onChange( valueChange?? false);
              }, value: widget.initialValue,),
          Text(widget.name, style: AppTextStyles.roboto12regular),
        ]),
      ],
    );
  }
}


