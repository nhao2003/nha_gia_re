import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/enums/property_enums.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';

class BottomSheetRadio extends StatefulWidget {
  const BottomSheetRadio({super.key});

  @override
  State<BottomSheetRadio> createState() => _BottomSheetRadioState();
}

class _BottomSheetRadioState extends State<BottomSheetRadio> {
  static List<String> types = ["Căn Hộ chung Cư", "Nhà ở", "Đất", "Văn Phòng"];

  PropertyType selectedType = PropertyType.apartment;

  void onChanged(PropertyType? value) {
    setState(() {
      selectedType = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(types[0]),
            trailing: Radio(
              value: PropertyType.apartment,
              groupValue: selectedType,
              onChanged: onChanged,
            ),
          ),
          ListTile(
            title: Text(types[1]),
            trailing: Radio(
              value: PropertyType.house,
              groupValue: selectedType,
              onChanged: onChanged,
            ),
          ),
          ListTile(
            title: Text(types[2]),
            trailing: Radio(
              value: PropertyType.land,
              groupValue: selectedType,
              onChanged: onChanged,
            ),
          ),
          ListTile(
            title: Text(types[3]),
            trailing: Radio(
              value: PropertyType.office,
              groupValue: selectedType,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
