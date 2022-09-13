import '../../models/hive_boxes.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import '../../models/cash_out_model.dart';

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({Key? key}) : super(key: key);

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
  @override
  Widget build(BuildContext context) {
    final _cashOutProvider = Provider.of<CashOutModelProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CASH OUTS',
          style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                HiveBoxes.getCashOutData().clear();
              },
              child: Text(
                'CLEAR',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontFamily: 'Quicksand',
                    color: Colors.white),
              )),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(3.sp),
                child: Text(
                    'Total Cash Out: ₱ ' +
                        NumberFormat().format(_cashOutProvider.overallCashOut),
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Expanded(
              child: ValueListenableBuilder<Box<CashOutModel>>(
            valueListenable: HiveBoxes.getCashOutData().listenable(),
            builder: (context, box, _) {
              _cashOutProvider.listOfCashOuts =
                  box.values.toList().cast<CashOutModel>();
              return GroupedListView<CashOutModel, DateTime>(
                elements: _cashOutProvider.listOfCashOuts,
                groupBy: (e) => e.dateTime,
                itemBuilder: (context, e) {
                  return Card(
                    elevation: 8.0,
                    child: Padding(
                      padding: EdgeInsets.all(3.0.sp),
                      child: SizedBox(
                        height: 5.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Cash Out: ₱ ' +
                                        NumberFormat().format(e.cashOut),
                                    style: TextStyle(
                                      fontSize: 8.5.sp,
                                      fontFamily: 'Quicksand',
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat().format(e.dateTime),
                                  style: TextStyle(
                                      fontSize: 8.5.sp,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                groupSeparatorBuilder: (DateTime date) => Text(
                  '',
                  style: TextStyle(fontSize: 2),
                ),
                itemComparator: (item1, item2) =>
                    item2.dateTime.compareTo(item1.dateTime),
                order: GroupedListOrder.ASC,
              );
            },
          ))
        ],
      ),
    );
  }
}
