import 'package:inoveMilk/bloc/home.dart';
import 'package:inoveMilk/bloc/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:inoveMilk/view/buscar_produtor.dart';

class MenuLateral extends StatelessWidget {
  static LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();
  HomeBloc _bloc = BlocProvider.getBloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.3,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("images/2.png"),
                      fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("Lançar coleta"),
            leading: Icon(Icons.input),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BuscarProdutor()));
            },
          ),
          ListTile(
            title: Text("Check-in laticínio"),
            leading: Icon(Icons.room),
            onTap: () {
              _bloc.checkin(context);
              {}
            },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              bloc.logOut(context);
            },
          )
        ],
      ),
    );
  }
}
