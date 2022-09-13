import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'distribution_tile.dart';
import '../../models/distribution_model.dart';
import '../../models/hive_boxes.dart';

class DistributionScreen extends StatelessWidget {
  const DistributionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _distributionProvider =
        Provider.of<DistributionModelProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(5.0.sp),
                child: SizedBox(
                  width: 90.w,
                  child: TextField(
                    onChanged: (val) {
                      _distributionProvider.googleListOfDistribution(val);
                    },
                    style: TextStyle(fontSize: 10.sp),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand'),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 12.sp,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'DISTRIBUTION COST: ₱ ' +
                    NumberFormat()
                        .format(_distributionProvider.totalDistributionCost),
                style: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand'),
              ),
              Spacer()
            ],
          ),
          Expanded(
              child: ValueListenableBuilder<Box<DistributionModel>>(
                  valueListenable: HiveBoxes.getDistributionData().listenable(),
                  builder: (context, box, _) {
                    final _distributionProducts =
                        box.values.toList().cast<DistributionModel>();
                    return Consumer<DistributionModelProvider>(
                      builder: (context, data, child) {
                        return GroupedListView<DistributionModel, DateTime>(
                          elements: _distributionProducts,
                          groupBy: (e) => e.dateTime,
                          itemBuilder: (context, e) {
                            if (_distributionProvider
                                .getDistributionSearch()
                                .isEmpty) {
                              return DistributionTile(distributionModelTile: e);
                            } else if (DateFormat()
                                .format(e.dateTime)
                                .toLowerCase()
                                .contains(_distributionProvider
                                    .getDistributionSearch())) {
                              return DistributionTile(distributionModelTile: e);
                            } else {
                              return Container();
                            }
                          },
                          groupSeparatorBuilder: (DateTime date) => Text(
                            '',
                            style: TextStyle(fontSize: 0),
                          ),
                          itemComparator: (item1, item2) =>
                              item1.dateTime.compareTo(item2.dateTime),
                          order: GroupedListOrder.DESC,
                        );
                      },
                    );
                  }))
        ],
      ),
    );
  }
}
