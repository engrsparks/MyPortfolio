import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'cash_out_model.g.dart';

@HiveType(typeId: 9)
class CashOutModel extends HiveObject {
  @HiveField(73)
  final DateTime dateTime;
  @HiveField(74)
  final double cashOut;
  @HiveField(75)
  final double cashIn;

  CashOutModel({
    required this.dateTime,
    required this.cashOut,
    required this.cashIn
  });
}

class CashOutModelProvider with ChangeNotifier {
  List<CashOutModel> listOfCashOuts = [];
  List<CashOutModel> listOfCashIns = [];

  void addCashOut(double amount) {
    final _cashOutModel = CashOutModel(
      dateTime: DateTime.now(),
      cashOut: amount,
      cashIn: 0
    );
    listOfCashOuts.add(_cashOutModel);
    HiveBoxes.getCashOutData().add(_cashOutModel);
    notifyListeners();
  }

  void addCashIn(double amount) {
    final _cashOutModel = CashOutModel(
        dateTime: DateTime.now(),
        cashOut: 0,
        cashIn: amount
    );
    listOfCashOuts.add(_cashOutModel);
    HiveBoxes.getCashOutData().add(_cashOutModel);
    notifyListeners();
  }

  double get overallCashOut {
    var total = 0.0;

    for (int i = 0; i < listOfCashOuts.length; i++) {
      total = total + (listOfCashOuts[i].cashOut);
    }
    return total;
  }




}
