import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LancarColetaBloc implements BlocBase {
  LancarColetaBloc() {
    _initBloc();
  }
  BuildContext _localcontext;

  void _initBloc() async {}

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
