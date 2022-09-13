import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../models/distribution_model.dart';

class DistributionTile extends StatefulWidget {
  final DistributionModel distributionModelTile;
  const DistributionTile({Key? key, required this.distributionModelTile})
      : super(key: key);

  @override
  State<DistributionTile> createState() => _DistributionTileState();
}

class _DistributionTileState extends State<DistributionTile> {
  final TextEditingController _authorizationCodeController =
      TextEditingController();
  final String _authorizationCode = 'WSX321ASD';
  final Color _pressedColor = Colors.black12;
  final Color _unPressedColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    final _distributionProvider =
        Provider.of<DistributionModelProvider>(context);
    return Card(
      color: widget.distributionModelTile.isClicked
          ? _unPressedColor
          : _pressedColor,
      elevation: 8,
      child: SizedBox(
        height: 6.h,
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.distributionModelTile.isClicked =
                  !widget.distributionModelTile.isClicked;
            });

            !widget.distributionModelTile.isClicked
                ? Provider.of<DistributionModelProvider>(context, listen: false)
                    .calculateDistribution(
                        widget.distributionModelTile.index,
                        widget.distributionModelTile.name,
                        widget.distributionModelTile.cost,
                        widget.distributionModelTile.price,
                        widget.distributionModelTile.quantity)
                : Provider.of<DistributionModelProvider>(context, listen: false)
                    .removeCalculation(widget.distributionModelTile.index);
          },
          child: Padding(
            padding: EdgeInsets.all(3.sp),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cost: ₱ ' +
                          NumberFormat()
                              .format(widget.distributionModelTile.cost),
                      style: TextStyle(
                          fontSize: 8.5.sp,
                          fontFamily: 'Quicksand',
                          color: Colors.black),
                    ),
                    Text(
                      'Price: ₱ ' +
                          NumberFormat()
                              .format(widget.distributionModelTile.price),
                      style: TextStyle(
                          fontSize: 8.5.sp,
                          fontFamily: 'Quicksand',
                          color: Colors.black),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.distributionModelTile.name,
                      style: TextStyle(
                          fontSize: 8.5.sp,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      DateFormat()
                          .format(widget.distributionModelTile.dateTime),
                      style: TextStyle(
                        fontSize: 7.5.sp,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'QTY. ' +
                          widget.distributionModelTile.quantity.toString(),
                      style: TextStyle(
                          fontSize: 8.5.sp,
                          fontFamily: 'Quicksand',
                          color: Colors.black),
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
                                                padding: EdgeInsets.all(5.0.sp),
                                                child: TextField(
                                                  obscureText: true,
                                                  controller:
                                                      _authorizationCodeController,
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontFamily: 'Quicksand'),
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
                                                              Radius.circular(
                                                                  20)),
                                                      gradient: LinearGradient(
                                                          colors: const [
                                                            Colors.green,
                                                            Colors.blue
                                                          ])),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      if (_authorizationCodeController
                                                              .text ==
                                                          _authorizationCode) {
                                                        _distributionProvider
                                                            .deleteDistributedData(
                                                                widget
                                                                    .distributionModelTile
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
                                  ));
                        },
                        icon: Icon(
                          Icons.close,
                          size: 12.sp,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
