import 'package:flutter/foundation.dart';
import 'checkout_model.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'sales_report_model.g.dart';

@HiveType(typeId: 4)
class SalesReportModel {
  @HiveField(35)
  final int index;

  @HiveField(36)
  final String customerName;

  @HiveField(37)
  double cash;

  @HiveField(38)
  double cheque;

  @HiveField(39)
  double ar;

  @HiveField(40)
  final double discount;

  @HiveField(41)
  final double gross;

  @HiveField(42)
  final List<CheckOutModel> soldProducts;

  @HiveField(43)
  final DateTime dateTime;

  @HiveField(44)
  final int numberOfProducts;

  @HiveField(45)
  double cashOut;

  @HiveField(46)
  double cashIn;

  SalesReportModel(
      {required this.index,
        required this.customerName,
        required this.cash,
        required this.cheque,
        required this.ar,
        required this.discount,
        required this.gross,
        required this.soldProducts,
        required this.dateTime,
        required this.numberOfProducts,
        required this.cashOut,
        required this.cashIn});
}

class SalesReportModelProvider with ChangeNotifier {
  List<SalesReportModel> listOfSalesReport = [];

  void addSalesReport(
      int index,
      String customerName,
      double cash,
      double cheque,
      double ar,
      double discount,
      double gross,
      List<CheckOutModel> soldProducts,
      int numberOfProducts) {
    final _listOfSalesReportData = SalesReportModel(
        index: index,
        customerName: customerName,
        cash: cash,
        cheque: cheque,
        ar: ar,
        discount: discount,
        gross: gross,
        soldProducts: soldProducts,
        dateTime: DateTime.now(),
        numberOfProducts: numberOfProducts,
        cashOut: 0,
        cashIn: 0);
    listOfSalesReport.add(_listOfSalesReportData);
     HiveBoxes.getSalesReportData().put(index, _listOfSalesReportData);
    notifyListeners();
  }

  void saleReportAccountsReceivablePayment(
      String customerName,
      double cash,
      double cheque,
      double ar,
      double discount,
      double gross,
      List<CheckOutModel> soldProducts,
      DateTime dateTime,
      int numberOfProducts,
      double payment,
      int index,
      ) {
    final _listOfSalesReportData = SalesReportModel(
        index: index,
        customerName: customerName,
        cash: cash,
        cheque: cheque,
        ar: ar + payment,
        discount: discount,
        gross: gross,
        soldProducts: soldProducts,
        dateTime: dateTime,
        numberOfProducts: numberOfProducts,
        cashOut: 0,
        cashIn: 0);
   HiveBoxes.getSalesReportData().put(index, _listOfSalesReportData);
  }



  void deleteSalesReportData(int index) {
    HiveBoxes.getSalesReportData().delete(index);
  }

  double get salesReportCashOut {
    var total = 0.0;

    for (int i = 0; i < listOfSalesReport.length; i++) {
      total = total + (listOfSalesReport[i].cashOut);
    }
    return total;
  }

  double get salesReportCash {
    var total = 0.0;

    for (int i = 0; i < listOfSalesReport.length; i++) {
      total = total + (listOfSalesReport[i].cash);
    }
    return total;
  }

  double get salesReportCheque {
    var total = 0.0;

    for (int i = 0; i < listOfSalesReport.length; i++) {
      total = total + (listOfSalesReport[i].cheque);
    }
    return total;
  }

  double get salesReportAr {
    var total = 0.0;

    for (int i = 0; i < listOfSalesReport.length; i++) {
      total = total + (listOfSalesReport[i].ar);
    }
    return total;
  }

  int get salesReportProductsSold {
    var total = 0;

    for (int i = 0; i < listOfSalesReport.length; i++) {
      total = total + (listOfSalesReport[i].numberOfProducts);
    }
    return total;
  }

  double get salesReportGrossSales {
    var total = 0.0;

    for (int i = 0; i < listOfSalesReport.length; i++) {
      total = total + (listOfSalesReport[i].gross);
    }
    return total;
  }
}
