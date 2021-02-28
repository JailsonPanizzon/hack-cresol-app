import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

PreferredSizeWidget myAppBar(BuildContext context,
    {String title,
    Color bgColor,
    bool disableBack = false,
    List<Widget> traling,
    GlobalKey<ScaffoldState> scaffoldKey}) {
  return PreferredSize(
    preferredSize: Size(double.infinity, 120),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 60),
              Row(
                children: <Widget>[
                  scaffoldKey != null
                      ? IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 30,
                          ),
                          onPressed: () {
                            scaffoldKey.currentState.openDrawer();
                          },
                        )
                      : Container(),
                  disableBack
                      ? Icon(
                          Icons.arrow_back_ios,
                          color: Colors.transparent,
                        )
                      : IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                  Text(
                    title != null ? title : "",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 60),
          child: Row(
            children: traling == null ? [] : traling,
          ),
        )
      ],
    ),
  );
}
