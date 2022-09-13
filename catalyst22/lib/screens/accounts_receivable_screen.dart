import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../models/accounts_receivable_model.dart';
import '../../models/hive_boxes.dart';
import 'ar_collections_screen.dart';
import 'accounts_receivable_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';


class AccountsReceivableScreen extends StatefulWidget {
  const AccountsReceivableScreen({Key? key}) : super(key: key);

  @override
  State<AccountsReceivableScreen> createState() =>
      _AccountsReceivableScreenState();
}

class _AccountsReceivableScreenState extends State<AccountsReceivableScreen> {
  String _search = '';

  bool _refresh=true;

  @override
  Widget build(BuildContext context) {
    final _accountsReceivableProvider =
    Provider.of<AccountsReceivableModelProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0.sp),
                child: SizedBox(
                  width: 90.w,
                  child: TextField(
                   // autofocus: _autoFocus,
                    onChanged: (val) {
                      setState(() {
                        _search = val;
                      });
                    },
                    style: TextStyle(fontSize: 10.sp),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                      TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand'),
                      prefixIcon:
                          Icon(

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
              TextButton(
                  onPressed: () {
                    setState(() {
                          _refresh=false;
                    });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ArCollectionsScreen()));
                  },
                  child: Text(
                    'PRINT',
                    style: TextStyle(fontSize: 10.sp, fontFamily: 'Quicksand'),
                  )),
              Spacer(),
            ],
          ),
          _refresh?
          Expanded(
              child: ValueListenableBuilder<Box<AccountsReceivableModel>>(
                  valueListenable:
                  HiveBoxes.getAccountsReceivableData().listenable(),
                  builder: (context, box, _) {
                    _accountsReceivableProvider.listOfAccountsReceivables =
                        box.values.toList().cast<AccountsReceivableModel>();
                    return GroupedListView<AccountsReceivableModel, String>(

                      elements:
                      _accountsReceivableProvider.listOfAccountsReceivables,
                      groupBy: (e) => e.customerName,
                      itemBuilder: (context, e) {
                        if (_search.isEmpty) {
                          return AccountsReceivableTile(accountsReceivableModelTile: e,
                              );
                        } else if (DateFormat()
                            .format(e.dateTime)
                            .toLowerCase()
                            .contains(_search)) {
                          return  AccountsReceivableTile(accountsReceivableModelTile: e,
                          );
                        } else if (e.customerName
                            .toLowerCase()
                            .contains(_search)) {
                          return AccountsReceivableTile(accountsReceivableModelTile: e,
                          );
                        } else {
                          return Container();
                        }
                      },
                      groupSeparatorBuilder: (String name) {
                        if (name.toLowerCase().contains(_search)) {
                          return Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Quicksand'),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      itemComparator: (item1, item2) =>
                          item2.customerName.compareTo(item1.customerName),
                      order: GroupedListOrder.DESC,
                    );
                  })): Center(
                    child:
                         Column(
                           children: [
                             SizedBox(height: 15.h,),
                             Text('Transaction data are hidden for some reason.',style: TextStyle(
                             fontSize: 6.sp,
                             fontWeight: FontWeight.bold,
                             fontFamily: 'Lato'),),
                             TextButton(
                child: Text('Click here to show data',
                        style: TextStyle(
                                fontSize: 6.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lato'),),
                onPressed: (){
                    setState(() {
                      _refresh=true;
                    });
                },
              ),
                           ],
                         ),



                  )
        ],
      ),
    );
  }
}
