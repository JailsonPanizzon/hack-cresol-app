import 'package:inoveMilk/bloc/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class Register extends StatefulWidget {
  Register({this.email});
  final String email;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // MaskTextInputFormatter _numberMaskFormatter = new MaskTextInputFormatter(
  //     mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    print(widget.email);

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
                  // initialValue: widget.email != null ? widget.email : "",
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
                  child: Text("Register"),
                  onPressed: () {
                    _legister();

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

  void _legister() {
    LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();

    bloc.register(_emailController, _passwordController, context);
  }
}
