import 'package:marcelo/bloc/login.dart';
import 'package:marcelo/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class MenuLateral extends StatelessWidget {
  static LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.2,
            child: Center(
              child: Text("Logo bem bonito"),
            ),
          ),
          ListTile(
            title: Text("Usuário"),
            leading: Icon(Icons.person_add),
            onTap: () {},
          ),
          ListTile(
            title: Text("Vendas"),
            leading: Icon(Icons.people),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
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
