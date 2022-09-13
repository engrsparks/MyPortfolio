import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'monthly_sales_model.g.dart';

@HiveType(typeId: 8)
class MonthlySalesModel {
  @HiveField(66)
  final double cash;

  @HiveField(67)
  final double cheque;

  @HiveField(68)
  final double ar;

  @HiveField(69)
  final double netSales;

  @HiveField(70)
  final double grossProfit;

  @HiveField(71)
  final DateTime dateTime;

  @HiveField(72)
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


  double get monthlySalesCash {
    var total = 0.0;
    for (int i = 0; i < listOfMonthlySales.length; i++) {
      total = total + (listOfMonthlySales[i].cash);
    }
    return total;
  }

  double get monthlySalesCheque {
    var total = 0.0;
    for (int i = 0; i < listOfMonthlySales.length; i++) {
      total = total + (listOfMonthlySales[i].cheque);
    }
    return total;
  }

  double get monthlySalesAr {
    var total = 0.0;
    for (int i = 0; i < listOfMonthlySales.length; i++) {
      total = total + (listOfMonthlySales[i].ar);
    }
    return total;
  }

  int get monthlySalesProductsSold {
    var total = 0;
    for (int i = 0; i < listOfMonthlySales.length; i++) {
      total = total + (listOfMonthlySales[i].numberOfProductsSold);
    }
    return total;
  }



}
