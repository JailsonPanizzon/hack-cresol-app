import 'package:marcelo/bloc/login.dart';
import 'package:marcelo/bloc/usuario.dart';
import 'package:marcelo/config/theme.dart';
import 'package:marcelo/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => LoginBloc()),
        Bloc((i) => UsuariosBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        home: MySplashScreen(),
      ),
    );
  }
}
