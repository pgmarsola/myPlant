import 'package:flutter/material.dart';
import 'package:my_plant/utils/colors.dart';

class ApplicationBtn extends StatefulWidget {
  final String name;
  final Function route;

  ApplicationBtn(
    this.name,
    this.route,
  );

  @override
  _ApplicationBtnState createState() => _ApplicationBtnState();
}

class _ApplicationBtnState extends State<ApplicationBtn> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    return Container(
      color: transparent,
      height: screenHeight * 10,
      margin: EdgeInsets.symmetric(
          horizontal: screenHeight * 3, vertical: screenHeight * 3),
      child: RaisedButton(
        onPressed: widget.route,
        color: branco,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                screenHeight * 1.5,
              ),
            ),
            side: BorderSide(color: verde, width: 2)),
        child: Container(
          height: screenHeight * 10,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Image.asset(
                  "assets/plant.png",
                  scale: screenHeight * 4,
                ),
                backgroundColor: amarelo,
              ),
              Text(
                widget.name.toUpperCase(),
                style: TextStyle(color: chumbo),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: verde,
                size: screenHeight * 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
