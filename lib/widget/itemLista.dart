import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inoveMilk/modelos/coleta.dart';

class ItemList extends StatelessWidget {
  ItemList({this.coleta});

  final Coleta coleta;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              width: width * .15,
              margin: EdgeInsets.only(right: width * .02),
              child: Icon(
                Icons.person_pin,
                size: width * .15,
              ),
            ),
            Container(
              width: width * .65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    coleta.nomeProdutor != null ? coleta.nomeProdutor : "Nome",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      coleta.quantidade != null ? coleta.quantidade : "0" + "L",
                      style: Theme.of(context).textTheme.body2),
                  Text(coleta.temperatura + "°C",
                      style: Theme.of(context).textTheme.body2),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Divider()
      ],
    );
  }
}
