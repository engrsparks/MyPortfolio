import 'package:flutter/foundation.dart';

class ArCollectionsModel {
  final int index;
  final String customerName;

  final double ar;

  final double cash;
  final double cheque;

  final double balance;
  final double interest;

  final DateTime dateTime;
  final String address;

  ArCollectionsModel(
      {required this.index,
      required this.customerName,
      required this.ar,
      required this.cash,
      required this.cheque,
      required this.balance,
      required this.interest,
      required this.dateTime,
      required this.address});
}

class ArCollectionsModelProvider with ChangeNotifier {
  List<ArCollectionsModel> listOfAccountsReceivables = [];

  void addArCollections(
      int index,
      String customerName,
      double ar,
      double cash,
      double cheque,
      double balance,
      double interest,
      DateTime dateTime,
      String address) {
    listOfAccountsReceivables.add(ArCollectionsModel(
        index: index,
        customerName: customerName,
        ar: ar,
        cash: cash,
        cheque: cheque,
        balance: balance,
        interest: interest,
        dateTime: dateTime,
        address: address));

    notifyListeners();
  }

  void clearArCollections() {
    listOfAccountsReceivables = [];
    notifyListeners();
  }
}
