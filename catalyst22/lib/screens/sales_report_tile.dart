import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/sales_report_model.dart';
import '../../models/system_reports_model.dart';

class SalesReportTile extends StatefulWidget {
  final SalesReportModel salesReportModelTile;
  const SalesReportTile({Key? key, required this.salesReportModelTile})
      : super(key: key);

  @override
  State<SalesReportTile> createState() => SalesReportTileState();
}

class SalesReportTileState extends State<SalesReportTile> {
  bool _expand = false;

  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _authorizationCodeController =
  TextEditingController();
  final String _authorizationCode = '*AWDZSC12#';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 8,
          child: SizedBox(
            height: 8.5.h,
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
                        widget.salesReportModelTile.index.toString(),
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.salesReportModelTile.cheque != 0
                              ? Expanded(
                              child: Text(
                                'Cheque: ₱ ' +
                                    NumberFormat().format(
                                        widget.salesReportModelTile.cheque),
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 8.sp,
                                    color: Colors.red),
                              ))
                              : Container(),
                          Expanded(
                              child: Text(
                                'Cash: ₱ ' +
                                    NumberFormat()
                                        .format(widget.salesReportModelTile.cash),
                                style: TextStyle(
                                    fontFamily: 'Quicksand', fontSize: 8.sp),
                              )),
                          Expanded(
                              child: Text(
                                'Ar: ₱ ' +
                                    NumberFormat()
                                        .format(widget.salesReportModelTile.ar),
                                style: TextStyle(
                                    fontFamily: 'Quicksand', fontSize: 8.sp),
                              )),
                          Expanded(
                              child: Text(
                                'Discount: ₱ ' +
                                    NumberFormat().format(
                                        widget.salesReportModelTile.discount),
                                style: TextStyle(
                                    fontFamily: 'Quicksand', fontSize: 8.sp),
                              )),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.salesReportModelTile.customerName.toString(),
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        DateFormat()
                            .format(widget.salesReportModelTile.dateTime),
                        style:
                        TextStyle(fontFamily: 'Quicksand', fontSize: 7.sp),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.salesReportModelTile.ar == 0
                          ? Text(
                        'Fully Paid',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 8.sp,
                            fontFamily: 'Quicksand',
                            fontStyle: FontStyle.italic),
                      ):
                      Text(
                        'Pending',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 8.sp,
                            fontFamily: 'Quicksand',
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: widget.salesReportModelTile.ar == 0
                                ? null
                                : () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'PAYMENT TYPE',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontFamily:
                                          'Quicksand'),
                                    ),
                                    content: SizedBox(
                                      width: 70.w,
                                      height: 10.h,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Row(
                                            mainAxisSize:
                                            MainAxisSize
                                                .max,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Container(
                                                height: 4.h,
                                                width: 18.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(
                                                        20)),
                                                    gradient:
                                                    LinearGradient(
                                                        colors: const [
                                                          Colors
                                                              .green,
                                                          Colors
                                                              .blue
                                                        ])),
                                                child:
                                                TextButton(
                                                    onPressed:
                                                        () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Builder(builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  'PAYMENT FORM',
                                                                  style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
                                                                ),
                                                                content: Builder(builder: (context) {
                                                                  return SizedBox(
                                                                    height: 22.h,
                                                                    width: 50.w,
                                                                    child: SingleChildScrollView(
                                                                      child: Column(
                                                                        children: [
                                                                          Text(
                                                                            'Actual Payment: ₱ ' + NumberFormat().format(widget.salesReportModelTile.ar),style: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand', fontWeight: FontWeight.w700),),

                                                                          Padding(
                                                                            padding: EdgeInsets.all(5.0.sp),
                                                                            child: TextField(
                                                                              keyboardType: TextInputType.number,
                                                                              controller: _paymentController,
                                                                              style: TextStyle(fontSize: 10.sp),
                                                                              decoration: InputDecoration(hintText: 'Enter Cash', hintStyle: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand')),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 5.h),
                                                                            child: Container(
                                                                              height: 5.h,
                                                                              width: 18.w,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), gradient: LinearGradient(colors: const [Colors.green, Colors.blue])),
                                                                              child: TextButton(
                                                                                onPressed: () {
                                                                                  try {
                                                                                    if (double.parse(_paymentController.text) <= -(widget.salesReportModelTile.ar)) {

                                                                                      Provider.of<SalesReportModelProvider>(context,listen: false).saleReportAccountsReceivablePayment(widget.salesReportModelTile.customerName,
                                                                                          widget.salesReportModelTile.cash+double.parse(_paymentController.text), widget.salesReportModelTile.cheque, widget.salesReportModelTile.ar,
                                                                                          widget.salesReportModelTile.discount, widget.salesReportModelTile.gross, widget.salesReportModelTile.soldProducts,
                                                                                          widget.salesReportModelTile.dateTime, widget.salesReportModelTile.numberOfProducts, double.parse(_paymentController.text), widget.salesReportModelTile.index);


                                                                                      Navigator.of(context).pop();
                                                                                    } else {
                                                                                      Navigator.of(context).pop();
                                                                                      showDialog(
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return AlertDialog(
                                                                                              title: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              content: Builder(builder: (context) {
                                                                                                return SizedBox(
                                                                                                  height: 6.h,
                                                                                                  width: 90.w,
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                          padding: EdgeInsets.all(2.0.sp),
                                                                                                          child: Text(
                                                                                                            'This action can\'t proceed, an invalid text field value is detected.',
                                                                                                            style: TextStyle(fontSize: 9.sp, fontFamily: 'Quicksand'),
                                                                                                          )),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              }),
                                                                                            );
                                                                                          });
                                                                                    }
                                                                                  } catch (e) {
                                                                                    Navigator.of(context).pop();
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  'Confirm',
                                                                                  style: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand', color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              );
                                                            });
                                                          });
                                                    },
                                                    child:
                                                    Text(
                                                      'Cash',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Quicksand',
                                                          color: Colors.white),
                                                    )),
                                              ),
                                              Container(
                                                height: 4.h,
                                                width: 18.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(
                                                        20)),
                                                    gradient:
                                                    LinearGradient(
                                                        colors: const [
                                                          Colors
                                                              .green,
                                                          Colors
                                                              .blue
                                                        ])),
                                                child:
                                                TextButton(
                                                    onPressed:
                                                        () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Builder(builder: (context) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                  'PAYMENT FORM',
                                                                  style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
                                                                ),
                                                                content: Builder(builder: (context) {
                                                                  return SizedBox(
                                                                    height: 22.h,
                                                                    width: 50.w,
                                                                    child: SingleChildScrollView(
                                                                      child: Column(
                                                                        children: [
                                                                          Text(
                                                                            'Actual Payment: ₱ ' + NumberFormat().format(widget.salesReportModelTile.ar ),
                                                                            style: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand', fontWeight: FontWeight.w700),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.all(5.0.sp),
                                                                            child: TextField(
                                                                              keyboardType: TextInputType.number,
                                                                              controller: _paymentController,
                                                                              style: TextStyle(fontSize: 10.sp),
                                                                              decoration: InputDecoration(hintText: 'Enter Cash', hintStyle: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand')),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 5.h),
                                                                            child: Container(
                                                                              height: 5.h,
                                                                              width: 18.w,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), gradient: LinearGradient(colors: const [Colors.green, Colors.blue])),
                                                                              child: TextButton(
                                                                                onPressed: () {
                                                                                  try {
                                                                                    if (double.parse(_paymentController.text) <= -(widget.salesReportModelTile.ar)) {
                                                                                      Provider.of<SalesReportModelProvider>(context,listen: false).saleReportAccountsReceivablePayment(widget.salesReportModelTile.customerName,
                                                                                          widget.salesReportModelTile.cash+double.parse(_paymentController.text), widget.salesReportModelTile.cheque, widget.salesReportModelTile.ar,
                                                                                          widget.salesReportModelTile.discount, widget.salesReportModelTile.gross, widget.salesReportModelTile.soldProducts,
                                                                                          widget.salesReportModelTile.dateTime, widget.salesReportModelTile.numberOfProducts, double.parse(_paymentController.text), widget.salesReportModelTile.index);

                                                                                      Navigator.of(context).pop();
                                                                                    } else {
                                                                                      Navigator.of(context).pop();
                                                                                      showDialog(
                                                                                          context: context,
                                                                                          builder: (context) {
                                                                                            return AlertDialog(
                                                                                              title: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              content: Builder(builder: (context) {
                                                                                                return SizedBox(
                                                                                                  height: 6.h,
                                                                                                  width: 90.w,
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                          padding: EdgeInsets.all(2.0.sp),
                                                                                                          child: Text(
                                                                                                            'This action can\'t proceed, an invalid text field value is detected.',
                                                                                                            style: TextStyle(fontSize: 9.sp, fontFamily: 'Quicksand'),
                                                                                                          )),
                                                                                                    ],
                                                                                                  ),
                                                                                                );
                                                                                              }),
                                                                                            );
                                                                                          });
                                                                                    }
                                                                                  } catch (e) {
                                                                                    Navigator.of(context).pop();
                                                                                  }
                                                                                },
                                                                                child: Text(
                                                                                  'Confirm',
                                                                                  style: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand', color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              );
                                                            });
                                                          });
                                                    },
                                                    child:
                                                    Text(
                                                      'Cheque',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Quicksand',
                                                          color: Colors.white),
                                                    )),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            icon: Icon(
                              Icons.payment,
                              size: 12.sp,
                            ),
                          ),

                          Expanded(
                            child: IconButton(
                                onPressed: widget.salesReportModelTile
                                    .soldProducts.isEmpty
                                    ? null
                                    : () {
                                  setState(() {
                                    _expand = !_expand;
                                  });
                                },
                                icon: Icon(
                                  _expand
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  size: 12.sp,
                                )),
                          ),
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
                                              padding:
                                              EdgeInsets.all(5.0.sp),
                                              child: TextField(
                                                obscureText: true,
                                                controller:
                                                _authorizationCodeController,
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontFamily:
                                                    'Quicksand'),
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
                                                        Radius
                                                            .circular(
                                                            20)),
                                                    gradient:
                                                    LinearGradient(
                                                        colors: const [
                                                          Colors.green,
                                                          Colors.blue
                                                        ])),
                                                child: TextButton(
                                                  onPressed: () {
                                                    if (_authorizationCodeController
                                                        .text ==
                                                        _authorizationCode) {
                                                      Provider.of<SystemReportsModelProvider>(
                                                          context,
                                                          listen: false)
                                                          .addReport(
                                                          '(transaction) Customer name ${widget.salesReportModelTile.customerName} with invoice number ${widget.salesReportModelTile.index} was removed in the sales report section last,');
                                                      Provider.of<SalesReportModelProvider>(
                                                          context,
                                                          listen: false)
                                                          .deleteSalesReportData(
                                                          widget
                                                              .salesReportModelTile
                                                              .index);
                                                      _authorizationCodeController
                                                          .clear();
                                                      Navigator.of(context)
                                                          .pop();
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
                                                        color:
                                                        Colors.white),
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
                  )
                ],
              ),
            ),
          ),
        ),
        if (_expand)
          Container(
            padding: EdgeInsets.all(5.0.sp),
            height: min(
                widget.salesReportModelTile.soldProducts.length * 20.h + 10.0,
                180),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: widget.salesReportModelTile.soldProducts
                        .map((e) => Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.name,
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontFamily: 'Quicksand'),
                            ),
                            Text('${e.quantity} x ₱ ${e.price}',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontFamily: 'Quicksand'))
                          ],
                        )
                      ],
                    ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
