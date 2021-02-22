import 'package:inoveMilk/bloc/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // MaskTextInputFormatter _numberMaskFormatter = new MaskTextInputFormatter(
  //     mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.only(
              top: size.height * 0.30,
              left: size.width * 0.1,
              right: size.width * 0.1),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  autovalidate: _autoValidate,
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                child: TextFormField(
                  autovalidate: _autoValidate,
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Senha"),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.1),
                child: RaisedButton(
                  child: Text("Login"),
                  onPressed: () {
                    _login();

                    {
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _validator(value) {
    return value.length < 15 ? "Número inválido" : null;
  }

  void _login() {
    LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();

    bloc.tryLogin(_emailController, _passwordController, context);
  }
}
