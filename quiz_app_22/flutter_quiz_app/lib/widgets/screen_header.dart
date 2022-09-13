import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/common/theme_helper.dart';

class ScreenHeader extends StatelessWidget {
  final String backBtnImagePath;
  final String headerText;

  const ScreenHeader(this.headerText, {Key? key, this.backBtnImagePath = "assets/icons/back.png"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            child: Icon(Icons.arrow_back_ios,size: 40,color: ThemeHelper.accentColor,),
            // Image(
            //
            //   image: AssetImage(backBtnImagePath),
            //   width: 40,
            // ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            headerText,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
