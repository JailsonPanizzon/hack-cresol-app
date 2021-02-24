import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inoveMilk/bloc/login.dart';
import 'package:inoveMilk/modelos/coleta.dart';
import 'package:inoveMilk/modelos/motorista.dart';
import 'package:inoveMilk/view/home.dart';
import 'package:inoveMilk/widget/custom_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweetalert/sweetalert.dart';

class LancarColetaBloc implements BlocBase {
  LancarColetaBloc() {
    _initBloc();
  }
  BuildContext _localcontext;

  void _initBloc() async {}

  salvarColeta(BuildContext context, quantidade, temperatura, observacao,
      amostra, produtor) async {
    SweetAlert.show(
      context,
      title: "Salvando",
      style: SweetAlertStyle.loading,
    );
    DateTime now = new DateTime.now();
    List<Motorista> motorista =
        await BlocProvider.getBloc<LoginBloc>().getMotorista();
    DateTime hora = new DateTime(now.hour, now.minute);
    DateTime data = new DateTime(now.year, now.month, now.day);
    Position coordenada = await _determinePosition();
    Coleta coleta = new Coleta(
        amostra: amostra,
        quantidade: quantidade,
        produtor: produtor.nome,
        temperatura: temperatura,
        observacao: observacao,
        data: data.toString(),
        hora: hora.toString(),
        coordenadas: coordenada.toString(),
        motorista: motorista[0].idUsuario);

    Firestore.instance
        .collection('coleta')
        .document()
        .setData(coleta.toJson())
        .then((value) {
      SweetAlert.show(context,
          title: "salvo com sucesso",
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
          subtitle: "Erro ao adicionar o cliente a sua lista",
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
