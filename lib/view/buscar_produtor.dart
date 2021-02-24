import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inoveMilk/bloc/buscar_produtor.dart';
import 'package:inoveMilk/modelos/produtor.dart';
import 'package:inoveMilk/view/lancar_coleta.dart';
import 'package:inoveMilk/widget/custom_button.dart';
import 'package:inoveMilk/widget/my_app_bar.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuscarProdutor extends StatefulWidget {
  @override
  _BuscarProdutorState createState() => _BuscarProdutorState();
}

class _BuscarProdutorState extends State<BuscarProdutor> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<AutoCompleteTextFieldState<Produtor>> key = new GlobalKey();

  TextEditingController _buscaController = new TextEditingController();
  Produtor _produtor;
  BuscarProdutorBloc _bloc = BlocProvider.getBloc<BuscarProdutorBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _heightField = 90;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: myAppBar(
          context,
          title: "Buscar produtor",
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: _heightField,
                    child: FutureBuilder<QuerySnapshot>(
                      future: _bloc.getProdutores(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        else
                          return _buildList(
                              _bloc.mapToList(snapshot.data.documents));
                      },
                    ),
                  ),
                  CustomButtom(
                    text: "Selecionar",
                    color: Colors.black,
                    textColor: Colors.white,
                    onPress: () {
                      selecionar(_produtor);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  selecionar(produtor) {
    if (_produtor != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LancarColeta(
            produtor: produtor,
          ),
        ),
      );
    }
  }

  _buildList(List<Produtor> snapshot) {
    return AutoCompleteTextField<Produtor>(
      key: key,
      decoration: InputDecoration(hintText: "Digite o nome do produtor"),
      controller: _buscaController,
      itemSubmitted: (item) {
        _produtor = item;
      },
      suggestions: snapshot,
      itemBuilder: (context, suggestion) => new Padding(
          child: new ListTile(
            title: new Text(suggestion.nome),
          ),
          padding: EdgeInsets.all(8.0)),
      clearOnSubmit: false,
      itemFilter: (suggestion, input) =>
          suggestion.nome.toLowerCase().startsWith(input.toLowerCase()),
    );
  }
}
