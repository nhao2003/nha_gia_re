import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PurchaseChoosePlanScreen extends StatefulWidget {
  const PurchaseChoosePlanScreen({super.key});

  @override
  State<PurchaseChoosePlanScreen> createState() =>
      _PurchaseChoosePlanScreenState();
}

class _PurchaseChoosePlanScreenState extends State<PurchaseChoosePlanScreen> {
  int selectedRadio = -1;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  List<int> months = [1, 3, 6, 12];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gói cơ bản"),
      ),
      bottomSheet: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
            ),
            onPressed: () {},
            child: Text("Mua ngay", style: TextStyle(color: AppColors.white),),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: months.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                tileColor: selectedRadio == index
                    ? AppColors.green.withOpacity(0.15)
                    : null,
                onTap: () {
                  setState(() {
                    selectedRadio = index;
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors.green,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                leading: Radio(
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => AppColors.green),
                  value: index,
                  groupValue: selectedRadio,
                  onChanged: (val) {
                    setSelectedRadio(val!);
                  },
                ),
                title: Text("Gói ${months[index]} tháng"),
                subtitle: Text("1.000.000đ"),
              ),
            );
          }),
    );
  }
}
