
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import '../../models/ar_collections_model.dart';
import '../../models/pdf_api.dart';

class ArCollectionsScreen extends StatelessWidget {
  const ArCollectionsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _arCollections = Provider.of<ArCollectionsModelProvider>(context);

    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   onPressed: (){
          //         Navigator.of(context).pop();
          //         Navigator.of(context).pop();
          //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
          //      MainScreen()));
          //   },
          //   icon: Icon(Icons.arrow_back_outlined,size: 12.sp,),
          // ),
        title: Text(
          'AR COLLECTIONS',
          style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                _arCollections.clearArCollections();
              },
              child: Text(
                'CLEAR',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'Quicksand',
                    color: Colors.white),
              )),
          SizedBox(
            width: 5.w,
          ),
          IconButton(
              onPressed: () async {
                try {
                  PdfDocument document = PdfDocument();
                  final page = document.pages.add();
                  //Draw rectangle

                  //Draw string
                  page.graphics.drawString(
                      '${Hive.box('enterprise_info').get('enterpriseName')}',
                      PdfStandardFont(PdfFontFamily.helvetica, 18),
                      brush: PdfBrushes.black,
                      bounds: Rect.fromLTWH(0, 0, 70.w, 8.h),
                      format: PdfStringFormat(
                          alignment: PdfTextAlignment.center,
                          lineSpacing: 5,
                          lineAlignment: PdfVerticalAlignment.top));
                  page.graphics.drawString(
                      '${Hive.box('enterprise_info').get('enterpriseAddress')}',
                      PdfStandardFont(PdfFontFamily.helvetica, 15),
                      brush: PdfBrushes.black,
                      bounds: Rect.fromLTWH(0, 20, 70.w, 8.h),
                      format: PdfStringFormat(
                          alignment: PdfTextAlignment.center,
                          lineSpacing: 5,
                          lineAlignment: PdfVerticalAlignment.top));
                  page.graphics.drawString(
                      '${Hive.box('enterprise_info').get('enterprisePhoneNumber')}',
                      PdfStandardFont(PdfFontFamily.helvetica, 15),
                      brush: PdfBrushes.black,
                      bounds: Rect.fromLTWH(0, 40, 70.w, 8.h),
                      format: PdfStringFormat(
                          alignment: PdfTextAlignment.center,
                          lineSpacing: 5,
                          lineAlignment: PdfVerticalAlignment.top));
                  page.graphics.drawString('STATEMENT OF ACCOUNT',
                      PdfStandardFont(PdfFontFamily.helvetica, 15),
                      brush: PdfBrushes.black,
                      bounds: Rect.fromLTWH(0, 40, 70.w, 8.h),
                      format: PdfStringFormat(
                          alignment: PdfTextAlignment.center,
                          lineSpacing: 5,
                          lineAlignment: PdfVerticalAlignment.middle));

                  for (int i = 0;
                  i < _arCollections.listOfAccountsReceivables.length;
                  i++) {
                    page.graphics.drawString(
                        _arCollections
                            .listOfAccountsReceivables[0].customerName,
                        PdfStandardFont(PdfFontFamily.helvetica, 13),
                        brush: PdfBrushes.black,
                        bounds: Rect.fromLTWH(0, 58, 70.w, 8.h),
                        format: PdfStringFormat(
                            alignment: PdfTextAlignment.center,
                            lineSpacing: 5,
                            lineAlignment: PdfVerticalAlignment.middle));
                  }

                  PdfGrid grid = PdfGrid();
                  grid.style = PdfGridStyle(
                    cellPadding: PdfPaddings(left: 5, right: 5),
                    font: PdfStandardFont(
                      PdfFontFamily.helvetica,
                      4.sp,
                    ),
                  );

                  grid.columns.add(count: 7);
                  grid.headers.add(1);

                  PdfGridRow header = grid.headers[0];
                  header.cells[0].value = 'Invoice No.';
                  header.cells[1].value = 'Date';
                  header.cells[2].value = 'Org. Balance';
                  header.cells[3].value = 'Interest Acc.';
                  header.cells[4].value = 'Cash';
                  header.cells[5].value = 'Cheque';
                  header.cells[6].value = 'Remaining Balance';

                  grid.applyBuiltInStyle(
                      PdfGridBuiltInStyle.gridTable5DarkAccent3);

                  for (int i = 0;
                  i < _arCollections.listOfAccountsReceivables.length;
                  i++) {
                    PdfGridRow row = grid.rows.add();

                    row.cells[0].value = _arCollections
                        .listOfAccountsReceivables[i].index
                        .toString();
                    row.cells[0].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[1].value = DateFormat.yMMMd().format(
                        _arCollections.listOfAccountsReceivables[i].dateTime);
                    row.cells[1].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[2].value = NumberFormat().format(_arCollections
                        .listOfAccountsReceivables[i].balance +
                        _arCollections.listOfAccountsReceivables[i].interest);
                    row.cells[2].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[3].value = NumberFormat().format(
                        _arCollections.listOfAccountsReceivables[i].interest);
                    row.cells[3].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[4].value = NumberFormat().format(
                        _arCollections.listOfAccountsReceivables[i].cash);
                    row.cells[4].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[5].value = NumberFormat().format(
                        _arCollections.listOfAccountsReceivables[i].cheque);
                    row.cells[5].stringFormat = PdfStringFormat(
                        lineAlignment: PdfVerticalAlignment.middle,
                        alignment: PdfTextAlignment.center);
                    row.cells[6].value = NumberFormat().format(
                        _arCollections.listOfAccountsReceivables[i].balance);
                    row.cells[6].stringFormat = PdfStringFormat(
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
                    bounds: Rect.fromLTWH(0, 11.h, 0, 0),
                  );

                  List<int> bytes = document.save();
                  document.dispose();

                  saveAndLaunchFile(bytes, 'ar_collections_report.pdf');
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Our Management System is Powered by Catalyst.',
                      style: TextStyle(
                          fontSize: 6.sp,
                          fontFamily: 'Lato',
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              'CUSTOMER STATEMENT OF ACCOUNT',
              style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _arCollections.listOfAccountsReceivables.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    child: SizedBox(
                      height: 7.5.h,
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
                                    _arCollections
                                        .listOfAccountsReceivables[index].index
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontFamily: 'Quicksand')),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Cash: ₱ ' +
                                            NumberFormat().format(_arCollections
                                                .listOfAccountsReceivables[
                                            index]
                                                .cash),
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            fontFamily: 'Quicksand'),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Cheque: ₱ ' +
                                            NumberFormat().format(_arCollections
                                                .listOfAccountsReceivables[
                                            index]
                                                .cheque),
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            fontFamily: 'Quicksand',
                                            color: Colors.red),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Ar: ₱ ' +
                                            NumberFormat().format(_arCollections
                                                .listOfAccountsReceivables[
                                            index]
                                                .ar),
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          fontFamily: 'Quicksand',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Interest: ₱ ' +
                                            NumberFormat().format(_arCollections
                                                .listOfAccountsReceivables[
                                            index]
                                                .interest),
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          fontFamily: 'Quicksand',
                                        ),
                                      ),
                                    ),
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
                                        _arCollections
                                            .listOfAccountsReceivables[index]
                                            .customerName,
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontFamily: 'Quicksand')),
                                Text(
                                  DateFormat().format(_arCollections
                                      .listOfAccountsReceivables[index]
                                      .dateTime),
                                  style: TextStyle(
                                      fontSize: 7.sp, fontFamily: 'Quicksand'),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Remaining Balance: ₱ ' +
                                        NumberFormat().format(_arCollections
                                            .listOfAccountsReceivables[index]
                                            .balance),
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        fontFamily: 'Quicksand'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
