import 'package:flutter/material.dart';
import 'package:my_plant/utils/colors.dart';

class ProgramBtn extends StatelessWidget {
  final String imgUrl;
  final String name;
  final Function route;

  ProgramBtn(this.imgUrl, this.name, this.route);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    return Container(
      color: transparent,
      height: screenHeight * 10,
      margin: EdgeInsets.symmetric(horizontal: screenHeight * 3),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: route,
                color: branco,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      topLeft: Radius.circular(45),
                      bottomRight: Radius.circular(screenHeight * 1.5),
                      topRight: Radius.circular(screenHeight * 1.5),
                    ),
                    side: BorderSide(color: verde, width: 2)),
                child: Container(
                    height: screenHeight * 8,
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 1.5,
                        top: screenHeight * 1.5,
                        right: screenHeight * 1.5,
                        left: screenHeight * 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name.toUpperCase(),
                            style: TextStyle(color: chumbo),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: verde,
                            size: screenHeight * 2.5,
                          ),
                        ],
                      ),
                    )),
              )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              imgUrl,
            ),
          ),
        ],
      ),
    );
  }
}
