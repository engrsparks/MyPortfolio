import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'screens/distribution_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/accounts_receivable_screen.dart';
import 'screens/system_reports_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final String _productionCode = 'YHNDFGZAQ##902855';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    Hive.close();
    super.dispose();
  }

  final TextEditingController _enterpriseNameController =
  TextEditingController();
  final TextEditingController _enterpriseAddressController =
  TextEditingController();
  final TextEditingController _enterpriseEmailController =
  TextEditingController();
  final TextEditingController _enterprisePhoneController =
  TextEditingController();
  final TextEditingController _productionCodeController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SystemReportsScreen();
            }));
          },
          child: Text(
            'RRRMC AGRIVET SUPPLY',
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed:Hive.box('license_code').isNotEmpty
                  ? null
                  :  () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PRODUCTION INFO',
                              style: TextStyle(
                                  fontSize: 12.sp, fontFamily: 'Quicksand'),
                            ),
                          ],
                        ),
                        content: Builder(builder: (context) {
                          return SizedBox(
                            height: 18.h,
                            width: 60.w,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5.0.sp),
                                    child: TextField(
                                      controller: _productionCodeController,
                                      style: TextStyle(fontSize: 10.sp),
                                      decoration: InputDecoration(
                                          hintText: 'Production Code',
                                          hintStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Quicksand')),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Container(
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
                                        if (_productionCodeController.text ==
                                            _productionCode) {
                                          var box = Hive.box('license_code');
                                          box.put('license_code',
                                              _productionCodeController.text);
                                          Navigator.of(context).pop();
                                        } else {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontSize: 8.sp,
                                            fontFamily: 'Quicksand',
                                            color: Colors.white),
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
                'SOFTWARE LICENSE',
                style: TextStyle(
                    fontSize: 8.sp,
                    fontFamily: 'Quicksand',
                    color: Colors.white),
              )),
          SizedBox(
            width: 5.w,
          ),
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ENTERPRISE INFO',
                              style: TextStyle(
                                  fontSize: 12.sp, fontFamily: 'Quicksand'),
                            ),
                            Container(
                              height: 4.h,
                              width: 15.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  gradient: LinearGradient(colors: const [
                                    Colors.green,
                                    Colors.blue
                                  ])),
                              child: TextButton(
                                onPressed: () {
                                  try {
                                    var box = Hive.box('enterprise_info');

                                    box.put('enterpriseName',
                                        _enterpriseNameController.text);
                                    box.put('enterpriseAddress',
                                        _enterpriseAddressController.text);
                                    box.put('enterprisePhoneNumber',
                                        _enterprisePhoneController.text);
                                    box.put('enterpriseEmail',
                                        _enterpriseEmailController.text);
                                    Navigator.of(context).pop();
                                  } catch (e) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      fontSize: 8.sp,
                                      fontFamily: 'Quicksand',
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        content: Builder(builder: (context) {
                          return SizedBox(
                            height: 28.h,
                            width: 60.w,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5.0.sp),
                                    child: TextField(
                                      controller: _enterpriseNameController,
                                      style: TextStyle(fontSize: 10.sp),
                                      decoration: InputDecoration(
                                          hintText: 'Enterprise Name',
                                          hintStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Quicksand')),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0.sp),
                                    child: TextField(
                                      controller: _enterprisePhoneController,
                                      style: TextStyle(fontSize: 10.sp),
                                      decoration: InputDecoration(
                                          hintText: 'Telephone No. / Phone No.',
                                          hintStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Quicksand')),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0.sp),
                                    child: TextField(
                                      controller: _enterpriseAddressController,
                                      style: TextStyle(fontSize: 10.sp),
                                      decoration: InputDecoration(
                                          hintText: 'Address',
                                          hintStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Quicksand')),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0.sp),
                                    child: TextField(
                                      controller: _enterpriseEmailController,
                                      style: TextStyle(fontSize: 10.sp),
                                      decoration: InputDecoration(
                                          hintText: 'Email Address',
                                          hintStyle: TextStyle(
                                              fontSize: 10.sp,
                                              fontFamily: 'Quicksand')),
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
              icon: Icon(
                Icons.business_outlined,
                size: 12.sp,
              )),
        ],
        bottom: TabBar(isScrollable: true, controller: _tabController, tabs: [
          Padding(
            padding: EdgeInsets.only(right: 5.5.w),
            child: Tab(
              child: Text(
                'DISTRIBUTION',
                style: TextStyle(fontSize: 12.sp, fontFamily: 'Lato'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w, left: 8.w),
            child: Tab(
              child: Text(
                'INVENTORY',
                style: TextStyle(fontSize: 12.sp, fontFamily: 'Lato'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w, left: 8.w),
            child: Tab(
              child: Text(
                'SALES',
                style: TextStyle(fontSize: 12.sp, fontFamily: 'Lato'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.5.w),
            child: Tab(
              child: Text(
                'ACCOUNTS RECEIVABLES',
                style: TextStyle(fontSize: 12.sp, fontFamily: 'Lato'),
              ),
            ),
          ),
        ]),
      ),
      body: TabBarView(controller: _tabController, children: const [
        DistributionScreen(),
        InventoryScreen(),
        SalesScreen(),
        AccountsReceivableScreen()
      ]),
    );
  }
}
