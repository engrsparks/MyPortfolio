import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../models/monthly_sales_model.dart';
import '../../models/hive_boxes.dart';
import 'monthly_sales_tile.dart';

class MonthlySalesScreen extends StatelessWidget {
  const MonthlySalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _monthlySalesProvider =
        Provider.of<MonthlySalesModelProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MONTHLY SALES',
          style: TextStyle(fontSize: 12.sp, fontFamily: 'Quicksand'),
        ),
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
          Expanded(
            child: ValueListenableBuilder<Box<MonthlySalesModel>>(
                valueListenable: HiveBoxes.getMonthlySalesData().listenable(),
                builder: (context, box, _) {
                  _monthlySalesProvider.listOfMonthlySales =
                      box.values.toList().cast<MonthlySalesModel>();
                  return GroupedListView<MonthlySalesModel, DateTime>(
                    elements: _monthlySalesProvider.listOfMonthlySales,
                    groupBy: (e) => e.dateTime,
                    itemBuilder: (context, e) {
                      return MonthlySalesTile(monthlySalesModelTile: e);
                    },
                    groupSeparatorBuilder: (DateTime date) => Text(''),
                    itemComparator: (item1, item2) =>
                        item1.dateTime.compareTo(item2.dateTime),
                    order: GroupedListOrder.DESC,
                  );
                }),
          )
        ],
      ),
    );
  }
}
