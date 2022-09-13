import 'package:flutter/material.dart';
import 'sales_report_model.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'daily_sales_model.g.dart';

@HiveType(typeId: 6)
class DailySalesModel {
  @HiveField(57)
  double cash;

  @HiveField(58)
  double ar;

  @HiveField(59)
  final double cheque;

  @HiveField(60)
  final double gross;

  @HiveField(61)
  final List<SalesReportModel> soldProducts;

  @HiveField(62)
  final DateTime dateTime;

  @HiveField(63)
  final int numberOfProducts;

  DailySalesModel({
    required this.cash,
    required this.ar,
    required this.cheque,
    required this.gross,
    required this.soldProducts,
    required this.dateTime,
    required this.numberOfProducts,
  });
}

class DailySalesModelProvider with ChangeNotifier {
  List<DailySalesModel> listOfDailySales = [];

  void addDailySales(
      double cash,
      double ar,
      double cheque,
      double gross,
      List<SalesReportModel> soldProducts,
      int numberOfProducts,
      ) {
    final _listOfDailySalesData = DailySalesModel(
      cash: cash,
      ar: ar,
      cheque: cheque,
      gross: gross,
      soldProducts: soldProducts,
      dateTime: DateTime.now(),
      numberOfProducts: numberOfProducts,
    );
    listOfDailySales.add(_listOfDailySalesData);

   HiveBoxes.getDailySalesData().add(_listOfDailySalesData);
    notifyListeners();
  }

  double get dailySalesCash {
    var total = 0.0;
    for (int i = 0; i < listOfDailySales.length; i++) {
      total = total + (listOfDailySales[i].cash);
    }
    return total;
  }

  double get dailySalesCheque {
    var total = 0.0;
    for (int i = 0; i < listOfDailySales.length; i++) {
      total = total + (listOfDailySales[i].cheque);
    }
    return total;
  }

  double get dailySalesAr {
    var total = 0.0;
    for (int i = 0; i < listOfDailySales.length; i++) {
      total = total + (listOfDailySales[i].ar);
    }
    return total;
  }

  int get dailySalesProductsSold {
    var total = 0;
    for (int i = 0; i < listOfDailySales.length; i++) {
      total = total + (listOfDailySales[i].numberOfProducts);
    }
    return total;
  }

  double get dailyGrossSales {
    var total = 0.0;
    for (int i = 0; i < listOfDailySales.length; i++) {
      total = total + (listOfDailySales[i].gross);
    }
    return total;
  }
}
