import 'package:flutter/material.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  @override
  _PurchaseHistoryScreenState createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  List<PurchaseHistory> purchaseHistory = [
    PurchaseHistory(
      id: '1',
      product: 'Product 1',
      date: '2023-07-01',
      amount: 19.99,
    ),
    PurchaseHistory(
      id: '2',
      product: 'Product 2',
      date: '2023-06-28',
      amount: 9.99,
    ),
    // Thêm các giao dịch khác...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: ListView.builder(
        itemCount: purchaseHistory.length,
        itemBuilder: (context, index) {
          final transaction = purchaseHistory[index];
          return Card(
            child: ListTile(
              title: Text('Transaction ID: ${transaction.id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product: ${transaction.product}'),
                  Text('Date: ${transaction.date}'),
                  Text('Amount: \$${transaction.amount}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PurchaseHistory {
  final String id;
  final String product;
  final String date;
  final double amount;

  PurchaseHistory({
    required this.id,
    required this.product,
    required this.date,
    required this.amount,
  });
}
