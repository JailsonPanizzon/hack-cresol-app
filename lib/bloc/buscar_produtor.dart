import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inoveMilk/bloc/login.dart';
import 'package:inoveMilk/modelos/motorista.dart';
import 'package:inoveMilk/modelos/produtor.dart';

class BuscarProdutorBloc implements BlocBase {
  BuscarProdutorBloc() {
    _initBloc();
  }
  String empresa;
  List<Produtor> listClientes = [];

  void _initBloc() async {}

  Future<QuerySnapshot> getProdutores(BuildContext context) async {
    List<Motorista> motorista =
        await BlocProvider.getBloc<LoginBloc>().getMotorista();
    empresa = motorista[0].empresa;
    print(motorista.map((f) {
      return f.empresa;
    }));
    return Firestore.instance
        .collection('produtor')
        .where("empresaAtual", isEqualTo: empresa)
        .getDocuments();
  }

  convert(List<DocumentSnapshot> doc) {
    return mapToList(doc);
  }

  //Convert map to produtor list
  List<Produtor> mapToList(List<DocumentSnapshot> docList) {
    List<Produtor> clienteList = [];
    List<String> clienteListName = [];
    docList.forEach((document) {
      Map<String, dynamic> cliente = document.data;
      if (cliente != null) {
        Produtor newProdutor = Produtor.fromMap(cliente);
        clienteList.add(newProdutor);
        clienteListName.add(newProdutor.nome);
      }
    });
    listClientes = clienteList;
    return clienteList;
  }

  @override
  void dispose() {}

  @override
  void addListener(listener) {}

  @override
  bool get hasListeners => null;

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}
}
