import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../models/accounts_receivable_model.dart';
import '../../models/ar_collections_model.dart';
import '../models/system_reports_model.dart';

class AccountsReceivableTile extends StatefulWidget {
  final AccountsReceivableModel accountsReceivableModelTile;

  const AccountsReceivableTile(
      {Key? key, required this.accountsReceivableModelTile })
      : super(key: key);

  @override
  State<AccountsReceivableTile> createState() => _AccountsReceivableTileState();
}

class _AccountsReceivableTileState extends State<AccountsReceivableTile> {
  final TextEditingController _authorizationCodeController =
  TextEditingController();
  final String _authorizationCode = '*AWDZSC12#';

  double _interestComputation(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (((to.difference(from).inHours / 24) /
        widget.accountsReceivableModelTile.gradient)
        .floor() *
        widget.accountsReceivableModelTile.interestCost *
        widget.accountsReceivableModelTile.numberOfBags);
  }

   bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
      _isSelected
          ? Colors.black12 : Colors.white,
      elevation: 8.0,
      child: SizedBox(
        height: 8.5.h,
        child: GestureDetector(
          onTap:
          _isSelected
              ? null
              : () {
            setState(() {
                _isSelected = true;

            });

            Provider.of<ArCollectionsModelProvider>(context,
                listen: false)
                .addArCollections(
                widget.accountsReceivableModelTile.invoiceNumber,
                widget.accountsReceivableModelTile.customerName,
                widget.accountsReceivableModelTile.ar,
                widget.accountsReceivableModelTile.cash,
                widget.accountsReceivableModelTile.cheque,
                (widget
                    .accountsReceivableModelTile.ar

                 // -_interestComputation(
                 //    DateTime(
                 //        widget.accountsReceivableModelTile
                 //            .dateTime.year,
                 //        widget.accountsReceivableModelTile
                 //            .dateTime.month,
                 //        widget.accountsReceivableModelTile
                 //            .dateTime.day),
                 //    DateTime.now())
                )
                // -widget.accountsReceivableModelTile.cash- widget.accountsReceivableModelTile.cheque
                , _interestComputation(
                DateTime(
                    widget.accountsReceivableModelTile
                        .dateTime.year,
                    widget.accountsReceivableModelTile
                        .dateTime.month,
                    widget.accountsReceivableModelTile
                        .dateTime.day),
                DateTime.now())

                ,
                widget.accountsReceivableModelTile.dateTime,
                widget.accountsReceivableModelTile.address);
          },
          child: Padding(
            padding: EdgeInsets.all(3.sp),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        widget.accountsReceivableModelTile.invoiceNumber
                            .toString(),
                        style:
                        TextStyle(fontSize: 8.sp, fontFamily: 'Quicksand')),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.accountsReceivableModelTile.cheque != 0
                            ? Expanded(
                          child: Text(
                            'Cheque: ₱ ' +
                                NumberFormat().format(widget
                                    .accountsReceivableModelTile.cheque),
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontFamily: 'Quicksand',
                                color: Colors.red),
                          ),
                        )
                            : Container(),
                        Expanded(
                          child: Text(
                            'Cash: ₱ ' +
                                NumberFormat().format(
                                    widget.accountsReceivableModelTile.cash),
                            style: TextStyle(
                                fontSize: 8.sp, fontFamily: 'Quicksand'),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Ar: ₱ ' +
                                NumberFormat().format(
                                    (widget.accountsReceivableModelTile.ar

                                        // _interestComputation(
                                        //     DateTime(
                                        //         widget
                                        //             .accountsReceivableModelTile
                                        //             .dateTime
                                        //             .year,
                                        //         widget
                                        //             .accountsReceivableModelTile
                                        //             .dateTime
                                        //             .month,
                                        //         widget
                                        //             .accountsReceivableModelTile
                                        //             .dateTime
                                        //             .day),
                                        //     DateTime.now())
                                    )
                                ),
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ),
                        widget.accountsReceivableModelTile.ar < 0
                            ? Expanded(
                          child: Text(
                            'Interest: ₱ ' +
                                NumberFormat().format(_interestComputation(
                                    DateTime(
                                        widget.accountsReceivableModelTile
                                            .dateTime.year,
                                        widget.accountsReceivableModelTile
                                            .dateTime.month,
                                        widget.accountsReceivableModelTile
                                            .dateTime.day),
                                    DateTime.now())),
                            style: TextStyle(
                                fontSize: 8.sp, fontFamily: 'Quicksand'),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Customer Name: ' +
                            widget.accountsReceivableModelTile.customerName,
                        style: TextStyle(
                          fontSize: 8.sp,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                        )),
                    Text(
                      DateFormat()
                          .format(widget.accountsReceivableModelTile.dateTime),
                      style: TextStyle(fontSize: 7.sp, fontFamily: 'Quicksand'),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                            'Remaining Balance: ₱ ' +
                                NumberFormat().format(
                                    widget.accountsReceivableModelTile.ar
                                ),
                            style: TextStyle(
                                fontSize: 8.sp, fontFamily: 'Quicksand'))
                      ],
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    IconButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      size: 20.sp,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      'WARNING!',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily: 'Quicksand'),
                                    ),
                                  ],
                                ),
                                content: Builder(builder: (context) {
                                  return SizedBox(
                                    height: 18.h,
                                    width: 50.w,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5.0.sp),
                                            child: TextField(
                                              obscureText: true,
                                              controller:
                                              _authorizationCodeController,
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontFamily: 'Quicksand'),
                                              decoration: InputDecoration(
                                                  hintText:
                                                  'Enter Authorization Code',
                                                  hintStyle: TextStyle(
                                                      fontSize: 10.sp)),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(top: 4.h),
                                            child: Container(
                                              height: 5.h,
                                              width: 18.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          20)),
                                                  gradient: LinearGradient(
                                                      colors: const [
                                                        Colors.green,
                                                        Colors.blue
                                                      ])),
                                              child: TextButton(
                                                onPressed: () {
                                                  if (_authorizationCodeController
                                                      .text ==
                                                      _authorizationCode) {
                                                    try {
                                                      Provider.of<SystemReportsModelProvider>(context,listen: false).addReport('Customer name ${widget.accountsReceivableModelTile.customerName} with an invoice no.${widget.accountsReceivableModelTile.invoiceNumber} was removed last,');
                                                      Provider.of<AccountsReceivableModelProvider>(
                                                          context,
                                                          listen: false)
                                                          .removeARData(widget
                                                          .accountsReceivableModelTile);
                                                      Navigator.of(context)
                                                          .pop();
                                                    } catch (e) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  } else {
                                                    Navigator.of(context)
                                                        .pop();
                                                  }
                                                },
                                                child: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontFamily:
                                                      'Quicksand',
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ));
                        },
                        icon: Icon(
                          Icons.close,
                          size: 12.sp,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
