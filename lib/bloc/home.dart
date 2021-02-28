import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inoveMilk/bloc/login.dart';
import 'package:inoveMilk/modelos/carga.dart';
import 'package:inoveMilk/modelos/coleta.dart';
import 'package:inoveMilk/modelos/motorista.dart';
import 'package:inoveMilk/view/home.dart';
import 'package:inoveMilk/widget/custom_alert.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:geolocator/geolocator.dart';

class HomeBloc implements BlocBase {
  HomeBloc() {
    _initBloc();
  }
  BuildContext _localcontext;

  List<Coleta> _coletasList;

  StreamController<List<Coleta>> _coletas =
      new StreamController<List<Coleta>>();
  Stream<QuerySnapshot> value;
  Stream get listaColetass => _coletas.stream;
  void _initBloc() async {}

  int filtro = 0;
  convert(List<DocumentSnapshot> doc) {
    return mapToList(doc);
  }

//Convert map to cliente list
  List mapToList(List<DocumentSnapshot> docList) {
    List<Coleta> coletaList = [];
    docList.forEach((document) {
      Map<String, dynamic> coleta = document.data;
      if (coleta != null) {
        Coleta newColeta = Coleta.fromMap(coleta);
        print(newColeta.carga == "-1");

        if (newColeta.carga == "-1") {
          newColeta.id = document.reference.documentID;
          coletaList.add(newColeta);
        }
      }
    });
    _coletasList = coletaList;
    return coletaList;
  }

  Future<QuerySnapshot> getColetas(BuildContext context) async {
    List<Motorista> motorista =
        await BlocProvider.getBloc<LoginBloc>().getMotorista();
    print(motorista[0].idUsuario);
    return Firestore.instance
        .collection('coleta')
        .where("motorista", isEqualTo: motorista[0].idUsuario)
        .getDocuments();
  }

  checkin(BuildContext context) async {
    SweetAlert.show(
      context,
      title: "Salvando",
      style: SweetAlertStyle.loading,
    );
    DateTime now = new DateTime.now();
    DateTime hora = new DateTime(now.hour, now.minute);
    DateTime data = new DateTime(now.year, now.month, now.day);
    Position coordenada = await _determinePosition();

    Carga carga = new Carga(
        data: data.toString(),
        hora: hora.toString(),
        coordenadas: coordenada.toString(),
        lote: "-1");
    print(carga);
    Firestore.instance.collection('carga').add(carga.toJson()).then((value) {
      _coletasList.forEach((coleta) {
        coleta.carga = value.documentID;
        print(coleta.carga);
        Firestore.instance
            .collection("coleta")
            .document(coleta.id)
            .setData(coleta.toJson());
      });
      _coletasList = [];

      SweetAlert.show(context,
          title: "Check-in realizado com sucesso",
          style: SweetAlertStyle.success,
          confirmButtonText: "OK",
          showCancelButton: false, onPress: (bool isConfirm) {
        if (isConfirm) {
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) => Home()), (e) {
            return false;
          });
          return false;
        }
        return true;
      });
    }).catchError((a) {
      Navigator.pop(context);
      customAlert(_localcontext,
          title: "Erro",
          subtitle: "Erro ao realizar check-in",
          style: "error", onPress: (bool isConfirm) {
        Navigator.pop(context);
      });
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void dispose() {
    _coletas.close();
  }

  @override
  void addListener(listener) {}

  @override
  void notifyListeners() {}

  @override
  void removeListener(listener) {}

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();
}
