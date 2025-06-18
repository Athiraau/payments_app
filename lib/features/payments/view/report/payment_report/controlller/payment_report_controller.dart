import 'package:flutter/material.dart';

class PaymentReportProvider with ChangeNotifier {
  ///List of items for payment report page
  final List<Map<String, dynamic>> _payments = [
    {
      "id": 1,
      "name": "John Doe",
      "amount": 1200,
      "status": "Paid",
      "date": "2025-01-01",
      "type": "Credit",
      "method": "Card"
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "amount": 800,
      "status": "Unpaid",
      "date": "2025-01-02",
      "type": "Debit",
      "method": "Cash"
    },
    {
      "id": 3,
      "name": "Tom Brown",
      "amount": 1500,
      "status": "Paid",
      "date": "2025-01-03",
      "type": "Credit",
      "method": "Online"
    },
  ];

  List<Map<String, dynamic>> get payments => _payments;
}
