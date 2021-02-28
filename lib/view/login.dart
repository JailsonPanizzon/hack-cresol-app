import 'package:inoveMilk/bloc/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:inoveMilk/widget/custom_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // MaskTextInputFormatter _numberMaskFormatter = new MaskTextInputFormatter(
  //     mask: '(##) # ####-####', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(253, 135, 12, 1),
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("images/1.png"),
                    fit: BoxFit.contain),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.30,
                  left: size.width * 0.1,
                  right: size.width * 0.1),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * .10),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: "Senha"),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.1),
                    child: CustomButtom(
                      text: "Login",
                      borderColor: Color.fromRGBO(23, 33, 33, 1),
                      color: Color.fromRGBO(23, 33, 33, 1),
                      textColor: Colors.white,
                      onPress: () {
                        _login();

                        {}
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    LoginBloc bloc = BlocProvider.getBloc<LoginBloc>();

    bloc.tryLogin(_emailController, _passwordController, context);
  }
}
