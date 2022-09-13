import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'monthly_sales_model.g.dart';

@HiveType(typeId: 8)
class MonthlySalesModel {
  @HiveField(60)
  final double cash;

  @HiveField(61)
  final double cheque;

  @HiveField(62)
  final double ar;

  @HiveField(63)
  final double netSales;

  @HiveField(64)
  final double grossProfit;

  @HiveField(65)
  final DateTime dateTime;

  @HiveField(66)
  final int numberOfProductsSold;

  MonthlySalesModel(
      {required this.cash,
      required this.cheque,
      required this.ar,
      required this.netSales,
      required this.grossProfit,
      required this.dateTime,
      required this.numberOfProductsSold});
}

class MonthlySalesModelProvider with ChangeNotifier {
  List<MonthlySalesModel> listOfMonthlySales = [];

  void addMonthlySales(double cash, double cheque, double ar, double netSales,
      double grossProfit, int numberOfProductsSold) {
    final _listOfMonthlySales = MonthlySalesModel(
        cash: cash,
        cheque: cheque,
        ar: ar,
        netSales: netSales,
        grossProfit: grossProfit,
        dateTime: DateTime.now(),
        numberOfProductsSold: numberOfProductsSold);
    listOfMonthlySales.add(_listOfMonthlySales);
    HiveBoxes.getMonthlySalesData().add(_listOfMonthlySales);
    notifyListeners();
  }
}
