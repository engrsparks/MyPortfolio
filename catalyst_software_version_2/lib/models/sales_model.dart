import 'package:flutter/material.dart';
import 'checkout_model.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'sales_model.g.dart';

@HiveType(typeId: 3)
class SalesModel {
  @HiveField(18)
  int index;

  @HiveField(19)
  final String customerName;

  @HiveField(20)
  double cash;

  @HiveField(21)
  double cheque;

  @HiveField(22)
  double ar;

  @HiveField(23)
  final double discount;

  @HiveField(24)
  final double gross;

  @HiveField(25)
  final List<CheckOutModel> soldProducts;

  @HiveField(26)
  final DateTime dateTime;

  @HiveField(27)
  final int numberOfProducts;

  @HiveField(28)
  double interestCost;

  @HiveField(29)
  double gradient;

  @HiveField(30)
  bool isSelected = true;

  @HiveField(31)
  double deliveryCharge;

  @HiveField(255)
  final String address;

  SalesModel(
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
      required this.interestCost,
      required this.gradient,
      required this.isSelected,
      required this.deliveryCharge,
      required this.address});
}

class SalesModelProvider with ChangeNotifier {
  List<SalesModel> listOfSales = [];
  List<SalesModel> listOfSalesComputations = [];

  String _search = '';
  bool _show = false;
  bool _showTabs = false;

  void addSales(
      int index,
      String customerName,
      double cash,
      double cheque,
      double ar,
      double discount,
      double gross,
      List<CheckOutModel> soldProducts,
      int numberOfProducts,
      double interestCost,
      double gradient,
      double deliveryCharge,
      String address) {
    final _listOfSales = SalesModel(
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
        interestCost: interestCost,
        gradient: gradient,
        isSelected: true,
        deliveryCharge: deliveryCharge,
        address: address);
    listOfSales.add(_listOfSales);
    HiveBoxes.getSalesData().put(index, _listOfSales);
    notifyListeners();
  }

  void addSalesComputation(
      int index,
      String customerName,
      double cash,
      double ar,
      double discount,
      double gross,
      List<CheckOutModel> soldProducts,
      int numberOfProducts,
      double interestCost,
      double gradient,
      double deliveryCharge,
      double cheque,
      String address) {
    listOfSalesComputations.add(SalesModel(
        index: index,
        customerName: customerName,
        cash: cash,
        ar: ar,
        discount: discount,
        gross: gross,
        soldProducts: soldProducts,
        dateTime: DateTime.now(),
        numberOfProducts: numberOfProducts,
        interestCost: interestCost,
        gradient: gradient,
        isSelected: true,
        deliveryCharge: deliveryCharge,
        cheque: cheque,
        address: address));

    notifyListeners();
  }

  void accountsReceivablePayment(
      String customerName,
      double cash,
      double cheque,
      double ar,
      double discount,
      double gross,
      List<CheckOutModel> soldProducts,
      DateTime dateTime,
      int numberOfProducts,
      int index,
      double interestCost,
      double gradient,
      double deliveryCharge,
      double payment,
      String address) {
    final _listOfSales = SalesModel(
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
        interestCost: interestCost,
        gradient: gradient,
        isSelected: true,
        deliveryCharge: deliveryCharge,
        address: address);
    HiveBoxes.getSalesData().put(index, _listOfSales);
  }

  double get totalSalesCash {
    var total = 0.0;
    for (int i = 0; i < listOfSalesComputations.length; i++) {
      total = total + (listOfSalesComputations[i].cash);
    }
    return total;
  }

  double get totalSalesCheque {
    var total = 0.0;
    for (int i = 0; i < listOfSalesComputations.length; i++) {
      total = total + (listOfSalesComputations[i].cheque);
    }
    return total;
  }

  double get totalSalesAr {
    var total = 0.0;
    for (int i = 0; i < listOfSalesComputations.length; i++) {
      total = total + (listOfSalesComputations[i].ar);
    }
    return total;
  }

  double get totalSalesProducts {
    var total = 0.0;
    for (int i = 0; i < listOfSalesComputations.length; i++) {
      total = total + (listOfSalesComputations[i].numberOfProducts);
    }
    return total;
  }

  double get totalSales {
    var total = 0.0;
    for (int i = 0; i < listOfSalesComputations.length; i++) {
      total = total +
          (listOfSalesComputations[i].cash - listOfSalesComputations[i].ar);
    }
    return total;
  }

  double get totalGrossSales {
    var total = 0.0;
    for (int i = 0; i < listOfSalesComputations.length; i++) {
      total = total + (listOfSalesComputations[i].gross);
    }
    return total;
  }

  void deleteSalesTileData(int index) {
    HiveBoxes.getSalesData().delete(index);
  }

  void removeSalesCalculation(int index) {
    listOfSalesComputations.removeWhere((element) => element.index == index);
    notifyListeners();
  }

  String getSalesSearch() => _search;
  bool getSalesShow() => _show;
  bool getSalesShowTabs() => _showTabs;

  salesShow() {
    _show = !_show;
    notifyListeners();
  }

  salesShowTabs() {
    _showTabs = !_showTabs;
    notifyListeners();
  }

  googleListOfSales(val) {
    _search = val;
    notifyListeners();
  }
}
