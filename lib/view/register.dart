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
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

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
                  // initialValue: widget.email != null ? widget.email : "",
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Container(
                child: TextFormField(
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _legister() {
    LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();

    bloc.register(_emailController, _passwordController, context);
  }
}
