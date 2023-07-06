import 'package:flutter/material.dart';
import 'package:nha_gia_re/data/models/purchase/transaction.dart';

import '../../../core/theme/app_colors.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  @override
  _PurchaseHistoryScreenState createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  List<Transaction> purchaseHistory = Transaction.generateFakeData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: ListView.separated(
        itemCount: purchaseHistory.length,
        itemBuilder: (context, index) {
          final transaction = purchaseHistory[index];
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text('Gói cơ bản 12 tháng'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Date: ${transaction.timeStamp}'),
                Text(
                  '\$${transaction.amount}',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
