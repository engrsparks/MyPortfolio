import 'package:catalyst22/models/sales_report_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/sales_model.dart';
import '../../models/accounts_receivable_model.dart';

import '../../models/system_reports_model.dart';

class SalesTile extends StatefulWidget {
  final SalesModel salesModelTile;
  const SalesTile({Key? key, required this.salesModelTile}) : super(key: key);

  @override
  State<SalesTile> createState() => _SalesTileState();
}

class _SalesTileState extends State<SalesTile> {
  bool _expand = false;

  final Color _pressedColor = Colors.black12;
  final Color _unPressedColor = Colors.white;
  final TextEditingController _authorizationCodeController =
  TextEditingController();
  final String _authorizationCode = '*AWDZSC12#';
  final TextEditingController _paymentController = TextEditingController();

  double _interestComputation(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (((to.difference(from).inHours / 24) /
        widget.salesModelTile.gradient)
        .floor() *
        widget.salesModelTile.interestCost *
        widget.salesModelTile.numberOfProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: widget.salesModelTile.isSelected
              ? _unPressedColor
              : _pressedColor,
          elevation: 8,
          child: SizedBox(
            height: 8.5.h,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.salesModelTile.isSelected =
                  !widget.salesModelTile.isSelected;
                });

                !widget.salesModelTile.isSelected
                    ? Provider.of<SalesModelProvider>(context, listen: false)
                    .addSalesComputation(
                    widget.salesModelTile.index,
                    widget.salesModelTile.customerName,
                    widget.salesModelTile.cash,
                    widget.salesModelTile.ar,
                    widget.salesModelTile.discount,
                    widget.salesModelTile.gross,
                    widget.salesModelTile.soldProducts,
                    widget.salesModelTile.numberOfProducts,
                    widget.salesModelTile.interestCost,
                    widget.salesModelTile.gradient,
                    widget.salesModelTile.deliveryCharge,
                    widget.salesModelTile.cheque,
                    widget.salesModelTile.address)
                    : Provider.of<SalesModelProvider>(context, listen: false)
                    .removeSalesCalculation(widget.salesModelTile.index);
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
                          widget.salesModelTile.index.toString(),
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.salesModelTile.cheque != 0
                                ? Expanded(
                                child: Text(
                                  'Cheque: ₱ ' +
                                      NumberFormat().format(
                                          widget.salesModelTile.cheque),
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
                                          .format(widget.salesModelTile.cash),
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 8.sp,
                                  ),
                                )),
                            Expanded(
                                child: widget.salesModelTile.ar <= 0
                                    ? Text(
                                  'Ar: ₱ ' +
                                      NumberFormat().format(
                                          widget.salesModelTile.ar),
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 8.sp),
                                )
                                    : Text(
                                    'Ar: ₱ ' +
                                        NumberFormat().format(
                                            (widget.salesModelTile.ar = 0)),
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 8.sp))),
                            Expanded(
                                child: Text(
                                  'Discount: ₱ ' +
                                      NumberFormat()
                                          .format(widget.salesModelTile.discount),
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
                          widget.salesModelTile.customerName.toString(),
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          DateFormat().format(widget.salesModelTile.dateTime),
                          style: TextStyle(
                              fontFamily: 'Quicksand', fontSize: 7.sp),
                        ),
                        widget.salesModelTile.ar != 0
                            ? Text(
                          'Interest Accumulated: ₱ ' +
                              NumberFormat().format(_interestComputation(
                                  DateTime(
                                      widget.salesModelTile.dateTime.year,
                                      widget
                                          .salesModelTile.dateTime.month,
                                      widget.salesModelTile.dateTime.day),
                                  DateTime.now())),
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 7.sp,
                              fontWeight: FontWeight.bold),
                        )
                            : Container(),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        widget.salesModelTile.ar >= 0
                            ? Text(
                          'Fully Paid',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 8.sp,
                              fontFamily: 'Quicksand',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700),
                        )
                            : Text(
                          'Pending',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 8.sp,
                              fontFamily: 'Quicksand',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: widget.salesModelTile.ar == 0
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
                                                                                  'Actual Payment: ₱ ' + NumberFormat().format(widget.salesModelTile.ar - _interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now())),
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
                                                                                          if (double.parse(_paymentController.text) <= -(widget.salesModelTile.ar - _interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now()))) {
                                                                                            Provider.of<SalesModelProvider>(context, listen: false).accountsReceivablePayment(widget.salesModelTile.customerName, (widget.salesModelTile.cash + double.parse(_paymentController.text)), widget.salesModelTile.cheque, widget.salesModelTile.ar, widget.salesModelTile.discount, widget.salesModelTile.gross, widget.salesModelTile.soldProducts, widget.salesModelTile.dateTime, widget.salesModelTile.numberOfProducts, widget.salesModelTile.index, widget.salesModelTile.interestCost, widget.salesModelTile.gradient, widget.salesModelTile.deliveryCharge, double.parse(_paymentController.text), widget.salesModelTile.address);
                                                                                            // Provider.of<CashOutModelProvider>(context,listen: false).addCashOut(double.parse(_paymentController.text));
                                                                                            if(widget.salesModelTile.dateTime.day == DateTime.now().day){
                                                                                              Provider.of<SalesReportModelProvider>(context,listen: false).saleReportAccountsReceivablePayment(widget.salesModelTile.customerName, (widget.salesModelTile.cash+ double.parse(_paymentController.text)), 0.0, (widget.salesModelTile.ar-_interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now())), widget.salesModelTile.discount,
                                                                                                  widget.salesModelTile.gross, widget.salesModelTile.soldProducts, widget.salesModelTile.dateTime, widget.salesModelTile.numberOfProducts, double.parse(_paymentController.text), widget.salesModelTile.index);
                                                                                            }else{
                                                                                              Provider.of<SalesReportModelProvider>(context,listen: false).saleReportAccountsReceivablePayment(widget.salesModelTile.customerName, (double.parse(_paymentController.text)), 0.0, (widget.salesModelTile.ar-_interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now())), widget.salesModelTile.discount,
                                                                                                  widget.salesModelTile.gross, widget.salesModelTile.soldProducts, DateTime.now(), 0, double.parse(_paymentController.text), widget.salesModelTile.index);
                                                                                            }
                                                                                            Provider.of<AccountsReceivableModelProvider>(context, listen: false).addAr(widget.salesModelTile.index, widget.salesModelTile.customerName, widget.salesModelTile.cash +double.parse(_paymentController.text), 0.0, (widget.salesModelTile.ar + double.parse(_paymentController.text) -_interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now()) ), widget.salesModelTile.interestCost, widget.salesModelTile.gradient, widget.salesModelTile.numberOfProducts, widget.salesModelTile.address);
                                                                                            //
                                                                                            // Provider.of<CashRegisterModelProvider>(context, listen: false).addCashRegister(widget.salesModelTile.customerName, widget.salesModelTile.index, double.parse(_paymentController.text), 0.0);
                                                                                            // Provider.of<CashFlowReportsModelProvider>(context, listen: false).addCashFlowReports(widget.salesModelTile.customerName, widget.salesModelTile.index, double.parse(_paymentController.text), 0.0, 0);

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
                                                                                  'Actual Payment: ₱ ' + NumberFormat().format(widget.salesModelTile.ar - _interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now())),
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
                                                                                          if (double.parse(_paymentController.text) <= -(widget.salesModelTile.ar - _interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now()))) {
                                                                                            Provider.of<SalesModelProvider>(context, listen: false).accountsReceivablePayment(widget.salesModelTile.customerName, (widget.salesModelTile.cash), (widget.salesModelTile.cheque + double.parse(_paymentController.text)), widget.salesModelTile.ar, widget.salesModelTile.discount, widget.salesModelTile.gross, widget.salesModelTile.soldProducts, widget.salesModelTile.dateTime, widget.salesModelTile.numberOfProducts, widget.salesModelTile.index, widget.salesModelTile.interestCost, widget.salesModelTile.gradient, widget.salesModelTile.deliveryCharge, double.parse(_paymentController.text), widget.salesModelTile.address);
                                                                                            Provider.of<AccountsReceivableModelProvider>(context, listen: false).addAr(widget.salesModelTile.index, widget.salesModelTile.customerName, 0.0,widget.salesModelTile.cheque+double.parse(_paymentController.text),(widget.salesModelTile.ar+double.parse(_paymentController.text) -_interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now())), widget.salesModelTile.interestCost,widget.salesModelTile.gradient,
                                                                                                widget.salesModelTile.numberOfProducts,widget.salesModelTile.address
                                                                                                // widget.salesModelTile.gradient, widget.salesModelTile.numberOfProducts, widget.salesModelTile.address
                                                                                            );

                                                                                            if(widget.salesModelTile.dateTime.day == DateTime.now().day){
                                                                                              Provider.of<SalesReportModelProvider>(context,listen: false).saleReportAccountsReceivablePayment(widget.salesModelTile.customerName, widget.salesModelTile.cash,(widget.salesModelTile.cheque +double.parse(_paymentController.text)),( widget.salesModelTile.ar-_interestComputation(DateTime(widget.salesModelTile.dateTime.year, widget.salesModelTile.dateTime.month, widget.salesModelTile.dateTime.day), DateTime.now())), widget.salesModelTile.discount,
                                                                                                  widget.salesModelTile.gross, widget.salesModelTile.soldProducts, widget.salesModelTile.dateTime, widget.salesModelTile.numberOfProducts, double.parse(_paymentController.text), widget.salesModelTile.index);
                                                                                            }else{
                                                                                              Provider.of<SalesReportModelProvider>(context,listen: false).saleReportAccountsReceivablePayment(widget.salesModelTile.customerName, 0.0,(double.parse(_paymentController.text)), (widget.salesModelTile.ar-double.parse(_paymentController.text)), widget.salesModelTile.discount,
                                                                                                  widget.salesModelTile.gross, widget.salesModelTile.soldProducts, DateTime.now(), 0, double.parse(_paymentController.text), widget.salesModelTile.index);
                                                                                            }

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
                                      onPressed: () {
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
                                        content:
                                        Builder(builder: (context) {
                                          return SizedBox(
                                            height: 18.h,
                                            width: 50.w,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        5.0.sp),
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
                                                          hintStyle:
                                                          TextStyle(
                                                              fontSize:
                                                              10.sp)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(
                                                        top: 4.h),
                                                    child: Container(
                                                      height: 5.h,
                                                      width: 18.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              20)),
                                                          gradient:
                                                          LinearGradient(
                                                              colors: const [
                                                                Colors
                                                                    .green,
                                                                Colors.blue
                                                              ])),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          if (_authorizationCodeController
                                                              .text ==
                                                              _authorizationCode) {
                                                            Provider.of<SystemReportsModelProvider>(
                                                                context,
                                                                listen:
                                                                false)
                                                                .addReport(
                                                                '(transaction) Customer name ${widget.salesModelTile.customerName} with invoice number ${widget.salesModelTile.index} was removed in the sales section last,');
                                                            Provider.of<SalesModelProvider>(
                                                                context,
                                                                listen:
                                                                false)
                                                                .deleteSalesTileData(widget
                                                                .salesModelTile
                                                                .index);
                                                            _authorizationCodeController
                                                                .clear();
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          } else {
                                                            Navigator.of(
                                                                context)
                                                                .pop();
                                                          }
                                                        },
                                                        child: Text(
                                                          'Confirm',
                                                          style: TextStyle(
                                                              fontSize:
                                                              10.sp,
                                                              fontFamily:
                                                              'Quicksand',
                                                              color: Colors
                                                                  .white),
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_expand)
          Container(
            padding: EdgeInsets.all(5.0.sp),
            height: min(
                widget.salesModelTile.soldProducts.length * 20.h + 10.0, 180),
            child: Column(
              children: [
                Row(
                  children: [
                    widget.salesModelTile.deliveryCharge == 0
                        ? Container()
                        : Text(
                      'Delivery Fee: ₱ ' +
                          NumberFormat().format(
                              widget.salesModelTile.deliveryCharge),
                      style: TextStyle(fontSize: 8.sp),
                    ),
                    Spacer(),
                    Text(widget.salesModelTile.address,
                        style:
                        TextStyle(fontSize: 8.sp, fontFamily: 'Quicksand')),
                    Spacer(),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: widget.salesModelTile.soldProducts
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
