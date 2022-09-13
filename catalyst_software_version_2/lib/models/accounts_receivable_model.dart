import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'hive_boxes.dart';

part 'accounts_receivable_model.g.dart';

@HiveType(typeId: 5)
class AccountsReceivableModel extends HiveObject {
  @HiveField(42)
  final int invoiceNumber;

  @HiveField(43)
  final String customerName;

  @HiveField(44)
  final double cash;

  @HiveField(45)
  final double cheque;

  @HiveField(46)
  final double ar;

  @HiveField(47)
  final DateTime dateTime;

  @HiveField(48)
  final double interestCost;

  @HiveField(49)
  final double gradient;

  @HiveField(50)
  final int numberOfBags;

  @HiveField(254)
  final String address;

  AccountsReceivableModel(
      {required this.customerName,
      required this.cash,
      required this.cheque,
      required this.ar,
      required this.dateTime,
      required this.invoiceNumber,
      required this.interestCost,
      required this.gradient,
      required this.numberOfBags,
      required this.address});
}

class AccountsReceivableModelProvider with ChangeNotifier {
  List<AccountsReceivableModel> listOfAccountsReceivables = [];

  void addAr(
      int index,
      String customerName,
      double cash,
      double cheque,
      double ar,
      double interestCost,
      double gradient,
      int numberOfBags,
      String address) {
    final _accountsReceivable = AccountsReceivableModel(
        invoiceNumber: index,
        customerName: customerName,
        cash: cash,
        cheque: cheque,
        ar: ar,
        dateTime: DateTime.now(),
        interestCost: interestCost,
        gradient: gradient,
        numberOfBags: numberOfBags,
        address: address);
    listOfAccountsReceivables.add(_accountsReceivable);
    HiveBoxes.getAccountsReceivableData().add(_accountsReceivable);
    notifyListeners();
  }

  void removeARData(AccountsReceivableModel accountsReceivableModel) {
    accountsReceivableModel.delete();
  }
}
