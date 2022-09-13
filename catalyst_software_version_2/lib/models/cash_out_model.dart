import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'cash_out_model.g.dart';

@HiveType(typeId: 9)
class CashOutModel extends HiveObject {
  @HiveField(67)
  final DateTime dateTime;
  @HiveField(68)
  final double cashOut;

  CashOutModel({
    required this.dateTime,
    required this.cashOut,
  });
}

class CashOutModelProvider with ChangeNotifier {
  List<CashOutModel> listOfCashOuts = [];

  void addCashOut(double amount) {
    final _cashOutModel = CashOutModel(
      dateTime: DateTime.now(),
      cashOut: amount,
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
