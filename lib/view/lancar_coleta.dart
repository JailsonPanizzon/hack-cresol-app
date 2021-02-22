import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:inoveMilk/bloc/lancar_coleta.dart';
import 'package:inoveMilk/widget/custom_button.dart';
import 'package:inoveMilk/widget/my_app_bar.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class LancarColeta extends StatefulWidget {
  @override
  _LancarColetaState createState() => _LancarColetaState();
}

class _LancarColetaState extends State<LancarColeta> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _quantidadeController = new TextEditingController();
  TextEditingController _temperaturaController = new TextEditingController();
  TextEditingController _amostraController = new TextEditingController();
  TextEditingController _observacaoController = new TextEditingController();
  FocusNode _quantidadeNode = FocusNode();
  FocusNode _temperaturaNode = FocusNode();
  FocusNode _amostraNode = FocusNode();
  FocusNode _observacaoNode = FocusNode();
  bool _amostra = false;

  LancarColetaBloc _bloc = BlocProvider.getBloc<LancarColetaBloc>();

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
          title: "Lançar coleta #clientenome",
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
                    child: TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Preencha este campo" : null;
                      },
                      controller: _quantidadeController,
                      style: TextStyle(color: Colors.black),
                      decoration: new InputDecoration(labelText: "Quantidade"),
                      keyboardType: TextInputType.number,
                      focusNode: _quantidadeNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (e) {
                        FocusScope.of(context).requestFocus(_temperaturaNode);
                      },
                    ),
                  ),
                  Container(
                    height: _heightField,
                    child: TextFormField(
                      focusNode: _temperaturaNode,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return value.isEmpty ? "Preencha este campo" : null;
                      },
                      controller: _temperaturaController,
                      decoration: InputDecoration(labelText: "Temperatura"),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    height: _heightField,
                    child: TextFormField(
                      focusNode: _observacaoNode,
                      textInputAction: TextInputAction.next,
                      controller: _observacaoController,
                      decoration: InputDecoration(labelText: "Observação"),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                      height: _heightField,
                      child: CheckboxListTile(
                        value: _amostra,
                        onChanged: (value) {
                          setState(() {
                            _amostra = value;
                          });
                        },
                        title: Text("Coleta de amostra"),
                      )),
                  CustomButtom(
                    text: "Salvar",
                    color: Colors.black,
                    textColor: Colors.white,
                    onPress: () {
                      _salvar();
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

  _salvar() {}
}
