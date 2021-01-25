import 'package:flutter/material.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/widgets/topbar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Products extends StatefulWidget {
  final List<Applications> _list;
  final int tamanho;

  Products(
    this._list,
    this.tamanho,
  );

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    var conta = 0.0;
    var valor = 1 / widget.tamanho;

    return Scaffold(
        backgroundColor: verdeclaro,
        appBar: TopBar(),
        body: Container(
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: screenHeight * 10,
                    width: size.width,
                    child: Column(
                      children: [
                        Text(
                          'Progresso das aplicações'.toUpperCase(),
                          style: TextStyle(
                              color: chumbo, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(screenHeight * 1.5),
                            child: new LinearPercentIndicator(
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2500,
                              percent: conta,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: amarelo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: widget.tamanho,
                      itemBuilder: (context, index) {
                        if (widget._list[index].application == 1 &&
                            conta != 1) {
                          setState(() {
                            conta = conta + valor;
                          });
                        }
                        return InkWell(
                          child: ListTile(
                            title: Text(widget._list[index].name),
                            subtitle: Text(widget._list[index].dose),
                            leading: CircleAvatar(
                              child: Text(widget._list[index].name[0]),
                              backgroundColor: amarelo,
                            ),
                          ),
                          onTap: () {},
                        );
                      },
                    ),
                  )
                ])));
  }
}
