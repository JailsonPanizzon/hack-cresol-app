import 'package:flutter/foundation.dart';
import 'package:inoveMilk/bloc/home.dart';
import 'package:inoveMilk/modelos/coleta.dart';
import 'package:inoveMilk/widget/itemLista.dart';
import 'package:inoveMilk/widget/menu_lateral.dart';
import 'package:inoveMilk/widget/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  HomeBloc _bloc = BlocProvider.getBloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        elevation: 100,
        child: MenuLateral(),
      ),
      appBar: myAppBar(context,
          title: "Últimas coletas",
          disableBack: true,
          bgColor: Colors.red,
          scaffoldKey: scaffoldKey),
      body:
          // Container(
          //     height: 100,
          //     child: Container(
          //       padding: EdgeInsets.all(20),
          //       child: Text(
          //         "Últimas coletas não sincronizadas",
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     )),
          Container(
        child: FutureBuilder<QuerySnapshot>(
          future: _bloc.getColetas(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Coleta> lista = _bloc.convert(snapshot.data.documents);
              return _buildList(lista);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildList(List<Coleta> _coletas) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _coletas.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemList(coleta: _coletas[index]);
        });
  }
}
