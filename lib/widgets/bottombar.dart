import 'package:flutter/material.dart';
import 'package:my_plant/utils/colors.dart';
import 'package:my_plant/utils/texts.dart';

class BottomBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height / 100;

    void _showDetails(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 1.5,
                        vertical: screenHeight * 1.5),
                    child: Scrollbar(
                        child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(descricao + '\n\n' + textolongo),
                      ],
                    ))));
          });
    }

    return InkWell(
      child: Container(
        color: branco,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ('Detalhes do programa'),
              style: TextStyle(color: chumbo, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onTap: () {
        _showDetails(context);
      },
    );
  }
}
