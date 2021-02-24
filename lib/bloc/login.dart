import 'package:inoveMilk/modelos/motorista.dart';
import 'package:inoveMilk/view/home.dart';
import 'package:inoveMilk/view/login.dart';
import 'package:inoveMilk/view/register.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:rypr/view/home.dart';
// import 'package:rypr/view/validarcodigo.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginBloc implements BlocBase {
  LoginBloc() {
    _initBloc();
  }
  FirebaseAuth firebaseAuth;
  FirebaseUser user;
  String empresa;
  BuildContext _localcontext;
  void _initBloc() async {
    firebaseAuth = FirebaseAuth.instance;
    user = await firebaseAuth.currentUser();
    empresa = null;
  }

  Future<List<Motorista>> getMotorista() async {
    user = await firebaseAuth.currentUser();
    QuerySnapshot motoristasQuery = await Firestore.instance
        .collection('motorista')
        .where("IdUsuario", isEqualTo: user.uid)
        .getDocuments();
    List<Motorista> motoristas = motoristasQuery.documents
        .map((doc) => Motorista(
            idUsuario: doc.data['IdUsuario'], empresa: doc.data['empresa']))
        .toList();
    print(motoristas.map((f) {
      return f.idUsuario;
    }));
    return motoristas;
  }

  getStatusAutentication(BuildContext context) async {
    _localcontext = context;
    user = await firebaseAuth.currentUser();
    if (user != null && user.getIdToken() != null) {
      if (user.isEmailVerified) {
        List<Motorista> motoristas = await getMotorista();
        if (motoristas.length < 1) {
          SweetAlert.show(context,
              title: "Acesso não altorizado",
              subtitle: "Somente motoristas tem acesso ao aplicativo de coleta",
              style: SweetAlertStyle.confirm,
              confirmButtonText: "OK",
              showCancelButton: true, onPress: (bool isConfirm) {
            if (isConfirm) {
              empresa = motoristas[0].empresa;
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => Login()),
                  (e) {
                return false;
              });
              return false;
            }
            return true;
          });
        } else {
          Navigator.pushAndRemoveUntil(
              _localcontext, MaterialPageRoute(builder: (context) => Home()),
              (e) {
            return false;
          });
        }
      } else {
        SweetAlert.show(context,
            title: "Confirme seu email",
            subtitle: "Enviamos um link de confirmação no seu email",
            style: SweetAlertStyle.confirm,
            confirmButtonText: "OK",
            showCancelButton: true, onPress: (bool isConfirm) {
          if (isConfirm) {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => Login()), (e) {
              return false;
            });
            return false;
          }
          return true;
        });
      }
    } else {
      Navigator.pushAndRemoveUntil(
          _localcontext, MaterialPageRoute(builder: (context) => Login()), (e) {
        return false;
      });
    }
  }

  tryLogin(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      getStatusAutentication(context);
    } catch (e) {
      print(e.code);
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        print('No user found for that email.');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Register(
                      email: emailController.text,
                    )));
      } else if (e.code == 'ERROR_WRONG_PASSWORD') {
        SweetAlert.show(context,
            title: "Senha errada",
            subtitle: "Utilize recuperar senha para criar uma nova senha",
            style: SweetAlertStyle.error,
            confirmButtonText: "OK");
      }
    }
  }

  logOut(BuildContext context) {
    _localcontext = context;
    firebaseAuth.signOut();
    Navigator.pushAndRemoveUntil(
        _localcontext, MaterialPageRoute(builder: (context) => Login()), (e) {
      return false;
    });
  }

  register(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) async {
    try {
      AuthResult registerResult =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      print(registerResult.user.displayName);
      try {
        if (!registerResult.user.isEmailVerified) {
          await registerResult.user.sendEmailVerification();
          SweetAlert.show(context,
              title: "Confirme seu email",
              subtitle: "Enviamos um link de confirmação no seu email",
              style: SweetAlertStyle.success,
              confirmButtonText: "OK",
              showCancelButton: true, onPress: (bool isConfirm) {
            if (isConfirm) {
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => Login()),
                  (e) {
                return false;
              });
              return false;
            }
            return true;
          });
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e.code);
      if (e.code == "ERROR_WEAK_PASSWORD") {
        SweetAlert.show(context,
            title: "Senha fraca",
            subtitle:
                "Não utilize sequências e utilize pelo menos uma letra e um número",
            style: SweetAlertStyle.error,
            confirmButtonText: "OK");
      } else if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        SweetAlert.show(context,
            title: "Este email já foi registrado",
            subtitle:
                "Caso tenha esquecido sua senha tente utilizar o botão recuperar senha",
            style: SweetAlertStyle.error,
            confirmButtonText: "OK");
      }
    }
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
