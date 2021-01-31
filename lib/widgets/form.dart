import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_plant/utils/colors.dart';

class FormText extends StatelessWidget {
  final String titulo;
  final TextEditingController _controller;

  FormText(this.titulo, this._controller);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    return titulo == 'Anotação'
        ? TextFormField(
            controller: this._controller,
            keyboardType: TextInputType.text,
            maxLength: 200,
            minLines: 5,
            maxLines: 5,
            validator: (valor) {
              if (valor.isEmpty && valor.length == 0) {
                return "Campo Obrigatório";
              }
            },
            decoration: new InputDecoration(
              hintText: this.titulo,
              labelStyle: TextStyle(color: verde),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: verde),
                borderRadius: BorderRadius.circular(screenHeight * 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: verde),
                borderRadius: BorderRadius.circular(screenHeight * 1.5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: verde),
                borderRadius: BorderRadius.circular(screenHeight * 1.5),
              ),
            ),
          )
        : TextFormField(
            inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
            controller: this._controller,
            validator: (valor) {
              if (valor.isEmpty && valor.length == 0) {
                return "Campo Obrigatório";
              }
            },
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              hintText: this.titulo,
              labelStyle: TextStyle(color: verde),
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: verde),
                borderRadius: BorderRadius.circular(screenHeight * 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: verde),
                borderRadius: BorderRadius.circular(screenHeight * 1.5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: verde),
                borderRadius: BorderRadius.circular(screenHeight * 1.5),
              ),
            ),
          );
  }
}
