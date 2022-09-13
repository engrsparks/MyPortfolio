import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'sales_report_tile.dart';
import '../../models/sales_report_model.dart';
import '../../models/daily_sales_model.dart';
import '../../models/cash_out_model.dart';
import '../../models/pdf_api.dart';
import '../../models/hive_boxes.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({Key? key}) : super(key: key);

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  final TextEditingController _invoiceController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cashOutAmountController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _salesReportProvider = Provider.of<SalesReportModelProvider>(context);
    final _cashOutProvider = Provider.of<CashOutModelProvider>(context);
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 10.h,
        width: 10.w,
        child: FloatingActionButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) {
                  return Builder(builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'PAYMENT INFO',
                        style:
                            TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
                      ),
                      content: Builder(builder: (context) {
                        return SizedBox(
                          height: 33.h,
                          width: 60.w,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0.sp),
                                  child: TextField(
                                    controller: _invoiceController,
                                    style: TextStyle(fontSize: 10.sp),
                                    decoration: InputDecoration(
                                        hintText: 'Invoice Number',
                                        hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Quicksand')),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0.sp),
                                  child: TextField(
                                    controller: _customerNameController,
                                    style: TextStyle(fontSize: 10.sp),
                                    decoration: InputDecoration(
                                        hintText: 'Customer Name / Description',
                                        hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Quicksand')),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0.sp),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: _amountController,
                                    style: TextStyle(fontSize: 10.sp),
                                    decoration: InputDecoration(
                                        hintText: 'Amount',
                                        hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Quicksand')),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.h),
                                  child: Container(
                                    height: 5.h,
                                    width: 18.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        gradient: LinearGradient(colors: const [
                                          Colors.green,
                                          Colors.blue
                                        ])),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                                                    height: 10.h,
                                                    width: 70.w,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              height: 4.h,
                                                              width: 18.w,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: const [
                                                                        Colors
                                                                            .green,
                                                                        Colors
                                                                            .blue
                                                                      ])),
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    try {
                                                                      if (_customerNameController
                                                                          .text
                                                                          .isNotEmpty) {
                                                                        _salesReportProvider.addSalesReport(
                                                                            int.parse(_invoiceController.text),
                                                                            _customerNameController.text,
                                                                            double.parse(_amountController.text),
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            [],
                                                                            0);
                                                                        _invoiceController
                                                                            .clear();
                                                                        _amountController
                                                                            .clear();
                                                                        _customerNameController
                                                                            .clear();
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      } else {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }
                                                                    } catch (e) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    'Cash',
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontFamily:
                                                                            'Quicksand',
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ),
                                                            Container(
                                                              height: 4.h,
                                                              width: 18.w,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: const [
                                                                        Colors
                                                                            .green,
                                                                        Colors
                                                                            .blue
                                                                      ])),
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    try {
                                                                      if (_customerNameController
                                                                          .text
                                                                          .isNotEmpty) {
                                                                        _salesReportProvider.addSalesReport(
                                                                            int.parse(_invoiceController.text),
                                                                            _customerNameController.text,
                                                                            0.0,
                                                                            double.parse(_amountController.text),
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            [],
                                                                            0);
                                                                        _invoiceController
                                                                            .clear();
                                                                        _amountController
                                                                            .clear();
                                                                        _customerNameController
                                                                            .clear();
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      } else {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }
                                                                    } catch (e) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                    'Cheque',
                                                                    style: TextStyle(
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontFamily:
                                                                            'Quicksand',
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontFamily: 'Quicksand',
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
                    );
                  });
                });
          },
          child: Icon(
            Icons.add,
            size: 12.sp,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'SALES REPORT',
          style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
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
                                style: TextStyle(
                                    fontSize: 12.sp, fontFamily: 'Quicksand'),
                              ),
                            ],
                          ),
                          content: Builder(builder: (context) {
                            return SizedBox(
                              height: 15.h,
                              width: 60.w,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      'Please make sure to print this section,\nBefore taking this action. Thank you!',
                                      style: TextStyle(
                                          fontSize: 9.sp,
                                          fontFamily: 'Quicksand'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.h),
                                          child: Container(
                                            height: 4.h,
                                            width: 15.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                gradient: LinearGradient(
                                                    colors: const [
                                                      Colors.green,
                                                      Colors.blue
                                                    ])),
                                            child: TextButton(
                                              onPressed: _salesReportProvider
                                                      .listOfSalesReport.isEmpty
                                                  ? null
                                                  : () {
                                                      Provider.of<DailySalesModelProvider>(
                                                              context,
                                                              listen: false)
                                                          .addDailySales(
                                                        _salesReportProvider
                                                            .salesReportCash,
                                                        _salesReportProvider
                                                            .salesReportAr,
                                                        _salesReportProvider
                                                            .salesReportCheque,
                                                        _salesReportProvider
                                                            .salesReportGrossSales,
                                                        _salesReportProvider
                                                            .listOfSalesReport
                                                            .toList(),
                                                        _salesReportProvider
                                                            .salesReportProductsSold,
                                                      );
                                                      HiveBoxes
                                                              .getSalesReportData()
                                                          .clear();
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                              child: Text(
                                                'DONE',
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 4.h),
                                          child: Container(
                                            height: 4.h,
                                            width: 15.w,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                gradient: LinearGradient(
                                                    colors: const [
                                                      Colors.green,
                                                      Colors.blue
                                                    ])),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'CANCEL',
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ));
              },
              child: Text(
                'SAVE',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'Quicksand',
                    color: Colors.white),
              )),
          SizedBox(
            width: 8.w,
          ),
          IconButton(
              onPressed: () async {
                try {
                  PdfDocument document = PdfDocument();
                  final page = document.pages.add();
                  //Draw rectangle
                  page.graphics.drawRectangle(
                      brush: PdfSolidBrush(PdfColor(66, 182, 245, 255)),
                      bounds: Rect.fromLTWH(0, 0, 70.w, 8.h));
                  //Draw string

                  page.graphics.drawString(
                      '${Hive.box('enterprise_info').get('enterpriseName')}',
                      PdfStandardFont(PdfFontFamily.helvetica, 20),
                      brush: PdfBrushes.white,
                      bounds: Rect.fromLTWH(10, 17.2, 70.w, 8.h),
                      format: PdfStringFormat(
                          alignment: PdfTextAlignment.center,
                          lineSpacing: 5,
                          lineAlignment: PdfVerticalAlignment.top));
                  page.graphics.drawString(
                      'DAILY SALES REPORT \n' +
                          DateFormat.yMMMd().format(DateTime.now()),
                      PdfStandardFont(PdfFontFamily.helvetica, 15),
                      brush: PdfBrushes.white,
                      bounds: Rect.fromLTWH(10, 17.2, 70.w, 8.h),
                      format: PdfStringFormat(
                          alignment: PdfTextAlignment.center,
                          lineSpacing: 5,
                          lineAlignment: PdfVerticalAlignment.middle));

                  page.graphics.drawString(
                    'Total Cash: ' +
                        NumberFormat()
                            .format(_salesReportProvider.salesReportCash),
                    PdfStandardFont(PdfFontFamily.helvetica, 13),
                    brush: PdfBrushes.black,
                    bounds: Rect.fromLTWH(10, 145, 70.w, 8.h),
                  );
                  page.graphics.drawString(
                    'Total Cheque: ' +
                        NumberFormat()
                            .format(_salesReportProvider.salesReportCheque),
                    PdfStandardFont(PdfFontFamily.helvetica, 13),
                    brush: PdfBrushes.black,
                    bounds: Rect.fromLTWH(10, 160, 70.w, 8.h),
                  );
                  page.graphics.drawString(
                    'Total Ar: ' +
                        NumberFormat()
                            .format(_salesReportProvider.salesReportAr),
                    PdfStandardFont(PdfFontFamily.helvetica, 13),
                    brush: PdfBrushes.black,
                    bounds: Rect.fromLTWH(10, 175, 70.w, 8.h),
                  );
                  page.graphics.drawString(
                    'Total No. Bags Sold: ' +
                        NumberFormat().format(
                            _salesReportProvider.salesReportProductsSold),
                    PdfStandardFont(PdfFontFamily.helvetica, 13),
                    brush: PdfBrushes.black,
                    bounds: Rect.fromLTWH(10, 190, 70.w, 8.h),
                  );

                  PdfGrid grid = PdfGrid();
                  grid.style = PdfGridStyle(
                    font: PdfStandardFont(
                      PdfFontFamily.helvetica,
                      4.5.sp,
                    ),
                  );
                  grid.columns.add(count: 6);
                  grid.headers.add(1);

                  PdfGridRow header = grid.headers[0];
                  header.cells[0].value = 'Customer \nName';
                  header.cells[1].value = 'No. of Bags Sold';
                  header.cells[2].value = 'Cash';
                  header.cells[3].value = 'Cheque';
                  header.cells[4].value = 'AR';
                  header.cells[5].value = 'Total';

                  grid.applyBuiltInStyle(
                      PdfGridBuiltInStyle.gridTable5DarkAccent3);

                  for (int i = 0;
                      i < _salesReportProvider.listOfSalesReport.length;
                      i++) {
                    PdfGridRow row = grid.rows.add();
                    row.cells[0].value =
                        _salesReportProvider.listOfSalesReport[i].customerName;

                    row.cells[0].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[1].value = NumberFormat().format(
                        _salesReportProvider
                            .listOfSalesReport[i].numberOfProducts);
                    row.cells[1].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[2].value = NumberFormat()
                        .format(_salesReportProvider.listOfSalesReport[i].cash);
                    row.cells[2].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[3].value = NumberFormat().format(
                        _salesReportProvider.listOfSalesReport[i].cheque);
                    row.cells[3].stringFormat = PdfStringFormat(
                      lineAlignment: PdfVerticalAlignment.middle,
                      alignment: PdfTextAlignment.center,
                    );
                    row.cells[4].value = NumberFormat()
                        .format(_salesReportProvider.listOfSalesReport[i].ar);
                    row.cells[4].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[5].value = NumberFormat().format(
                        (_salesReportProvider.listOfSalesReport[i].cash +
                            _salesReportProvider.listOfSalesReport[i].cheque -
                            _salesReportProvider.listOfSalesReport[i].ar));
                    row.cells[5].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                  }
                  for (int i = 0; i < header.cells.count; i++) {
                    header.cells[i].style.stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                  }

                  grid.draw(
                    page: page,
                    bounds: Rect.fromLTWH(0, 19.5.h, 0, 0),
                  );

                  List<int> bytes = document.save();
                  document.dispose();

                  saveAndLaunchFile(bytes, 'daily_sales_report.pdf');
                } catch (e) {
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.print,
                size: 12.sp,
              ))
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 18.w,
              ),
              Container(
                height: 3.h,
                width: 18.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: const [Colors.green, Colors.blue])),
                child: TextButton(
                    onPressed: HiveBoxes.getSalesReportData().isEmpty
                        ? null
                        : () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'CASH OUT FORM',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily: 'Quicksand'),
                                        ),
                                      ],
                                    ),
                                    content: Builder(builder: (context) {
                                      return SingleChildScrollView(
                                        child: SizedBox(
                                          height: 20.h,
                                          width: 60.w,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(5.0.sp),
                                                child: TextField(
                                                  controller:
                                                      _cashOutAmountController,
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                  decoration: InputDecoration(
                                                      hintText: 'Amount',
                                                      hintStyle: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontFamily:
                                                              'Quicksand')),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 4.5.h),
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
                                                      try {
                                                        Provider.of<CashOutModelProvider>(
                                                                context,
                                                                listen: false)
                                                            .addCashOut(
                                                                double.parse(
                                                                    _cashOutAmountController
                                                                        .text));
                                                        Navigator.of(context)
                                                            .pop();
                                                      } catch (e) {
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
                                  );
                                });
                          },
                    child: Text(
                      'CASH OUT',
                      style: TextStyle(fontSize: 8.sp, fontFamily: 'Quicksand'),
                    )
                    // Text(
                    //   'CASH OUT',
                    //   style: TextStyle(
                    //       fontSize: 8.sp,
                    //       fontFamily: 'Quicksand',
                    //       fontWeight: FontWeight.w600),
                    // ),
                    ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Text(
                  'SALES REPORTS FOR TODAY\'S TRANSACTIONS',
                  style: TextStyle(
                      fontSize: 12.sp, fontFamily: 'Lato', wordSpacing: 12),
                ),
              ),
              Spacer()
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CASH OUT: ₱ ' +
                              NumberFormat()
                                  .format(_cashOutProvider.overallCashOut),
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'TOTAL CASH: ₱ ' +
                              NumberFormat()
                                  .format(_salesReportProvider.salesReportCash),
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'TOTAL CHEQUE: ₱ ' +
                              NumberFormat().format(
                                  _salesReportProvider.salesReportCheque),
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'TOTAL AR: ₱ ' +
                          NumberFormat()
                              .format(_salesReportProvider.salesReportAr),
                      style: TextStyle(
                          fontSize: 8.sp,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'NO. OF BAGS SOLD: ' +
                          NumberFormat().format(
                              _salesReportProvider.salesReportProductsSold),
                      style: TextStyle(
                          fontSize: 8.sp,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TOTAL SALES: ₱ ' +
                          NumberFormat().format(
                              _salesReportProvider.salesReportCash +
                                  _salesReportProvider.salesReportCheque +
                                  (-_salesReportProvider.salesReportAr)),
                      style: TextStyle(
                          fontSize: 8.sp,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'GROSS PROFIT: ' +
                          NumberFormat().format(
                              _salesReportProvider.salesReportGrossSales),
                      style: TextStyle(
                          fontSize: 8.sp,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ]),
          Expanded(
              child: ValueListenableBuilder<Box<SalesReportModel>>(
            valueListenable: HiveBoxes.getSalesReportData().listenable(),
            builder: (context, box, _) {
              _salesReportProvider.listOfSalesReport =
                  box.values.toList().cast<SalesReportModel>();
              return GroupedListView<SalesReportModel, int>(
                elements: _salesReportProvider.listOfSalesReport,
                groupBy: (e) => e.index,
                itemBuilder: (context, e) {
                  return SalesReportTile(salesReportModelTile: e);
                },
                groupSeparatorBuilder: (int index) => Container(),
                itemComparator: (item1, item2) =>
                    item2.index.compareTo(item1.index),
                order: GroupedListOrder.DESC,
              );
            },
          ))
        ],
      ),
    );
  }
}
