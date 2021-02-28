import 'package:inoveMilk/bloc/buscar_produtor.dart';
import 'package:inoveMilk/bloc/home.dart';
import 'package:inoveMilk/bloc/lancar_coleta.dart';
import 'package:inoveMilk/bloc/login.dart';
import 'package:inoveMilk/bloc/usuario.dart';
import 'package:inoveMilk/config/theme.dart';
import 'package:inoveMilk/view/splash.dart';
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
        Bloc((i) => LancarColetaBloc()),
        Bloc((i) => BuscarProdutorBloc()),
        Bloc((i) => HomeBloc()),
      ],
      child: MaterialApp(
        title: 'inoveMilk',
        theme: themeData,
        home: MySplashScreen(),
      ),
    );
  }
}
