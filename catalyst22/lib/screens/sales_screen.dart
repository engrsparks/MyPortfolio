import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cash_out_screen.dart';
import 'sales_report_screen.dart';
import 'daily_sales_screen.dart';
import 'monthly_sales_screen.dart';
import 'sales_tile.dart';
import '../../models/sales_model.dart';
import '../../models/hive_boxes.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _salesProvider = Provider.of<SalesModelProvider>(context);
    return Scaffold(
      body: Consumer<SalesModelProvider>(
        builder: (context, data, _) => Column(
          children: [
            !_salesProvider.getSalesShowTabs()
                ? Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              _salesProvider.salesShow();
                            },
                            icon: Icon(
                              !_salesProvider.getSalesShow()
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_drop_up,
                              size: 16.sp,
                            )),
                        Padding(
                          padding: EdgeInsets.all(5.0.sp),
                          child: SizedBox(
                            width: 90.w,
                            child: TextField(
                              onChanged: (val) {
                                _salesProvider.googleListOfSales(val);
                              },
                              style: TextStyle(fontSize: 10.sp),
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: 'Quicksand'),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 12.sp,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    borderSide:
                                    BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CashOutScreen()));
                        },
                        child: Text(
                          'CASH OUT',
                          style: TextStyle(
                              fontSize: 10.sp, fontFamily: 'Quicksand'),
                        )),
                    Spacer(),
                  ],
                ),
                !_salesProvider.getSalesShow()
                    ? Padding(
                  padding: EdgeInsets.only(
                      left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(
                          Radius.elliptical(30.w, 15.h)),
                    ),
                    padding: EdgeInsets.all(5.sp),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SalesReportScreen()));
                            },
                            child: Text(
                              'SALES REPORT',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DailySalesScreen()));
                            },
                            child: Text(
                              'DAILY SALES',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MonthlySalesScreen()));
                            },
                            child: Text(
                              'MONTHLY SALES',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ]),
                  ),
                )
                    : Container(),
                _salesProvider.getSalesShow()
                    ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL CASH: ₱ ' +
                                NumberFormat().format(
                                    _salesProvider.totalSalesCash),
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'TOTAL CHEQUE: ₱ ' +
                                NumberFormat().format(_salesProvider
                                    .totalSalesCheque),
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL AR: ₱ ' +
                                NumberFormat().format(
                                    _salesProvider.totalSalesAr),
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'NO. OF BAGS SOLD: ' +
                                NumberFormat().format(_salesProvider
                                    .totalSalesProducts),
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ])
                    : Container(),
              ],
            )
                : Container(),
            Expanded(
                child: ValueListenableBuilder<Box<SalesModel>>(
                  valueListenable: HiveBoxes.getSalesData().listenable(),
                  builder: (context, box, _) {
                    _salesProvider.listOfSales =
                        box.values.toList().cast<SalesModel>();
                    return GroupedListView<SalesModel, int>(
                      elements: _salesProvider.listOfSales,
                      groupBy: (e) => e.index,
                      itemBuilder: (context, e) {
                        if (_salesProvider.getSalesSearch().isEmpty) {
                          return SalesTile(salesModelTile: e);
                        } else if (DateFormat()
                            .format(e.dateTime)
                            .toLowerCase()
                            .contains(_salesProvider.getSalesSearch())) {
                          return SalesTile(salesModelTile: e);
                        } else if (e.customerName
                            .toLowerCase()
                            .contains(_salesProvider.getSalesSearch())) {
                          return SalesTile(salesModelTile: e);
                        } else {
                          return Container();
                        }
                      },
                      groupSeparatorBuilder: (int index) {
                        if (_salesProvider.getSalesSearch().isNotEmpty) {
                          return Container();
                        } else {
                          return GestureDetector(
                            onTap: () {
                              _salesProvider.salesShowTabs();
                            },
                            child: Container(),
                          );
                        }
                      },
                      itemComparator: (item1, item2) =>
                          item2.index.compareTo(item1.index),
                      order: GroupedListOrder.DESC,
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
