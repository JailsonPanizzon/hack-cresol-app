import 'package:inoveMilk/bloc/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();

    bloc.getStatusAutentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(253, 135, 12, 1),
              image: DecorationImage(
                  image: AssetImage("images/1.png"), fit: BoxFit.fitWidth),
            ),
          ),
        ],
      ),
    );
  }
}
