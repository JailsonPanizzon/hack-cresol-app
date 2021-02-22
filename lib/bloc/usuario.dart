import 'dart:async';

import 'package:inoveMilk/modelos/usuario.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosBloc implements BlocBase {
  UsuariosBloc() {
    _initBloc();
  }
  void _initBloc() async {}

  Stream<QuerySnapshot> getUsuarios(BuildContext context) {}

  convert(List<DocumentSnapshot> doc) {
    return mapToList(doc);
  }

  //Convert map to usuario list
  List mapToList(List<DocumentSnapshot> docList) {
    List<Usuario> usuarioList = [];
    docList.forEach((document) {
      Map<String, dynamic> usuario = document.data;
      if (usuario != null) {
        Usuario newUsuario = Usuario.fromMap(usuario);
        newUsuario.idDoc = document.documentID;
        usuarioList.add(newUsuario);
      }
    });
    return usuarioList;
  }

  @override
  void addListener(void Function() listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(void Function() listener) {
    // TODO: implement removeListener
  }
}
