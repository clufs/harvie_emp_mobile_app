import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalWidget extends StatelessWidget {
  TotalWidget({
    Key? key,
    required this.total,
  }) : super(key: key);

  int total;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat.simpleCurrency();

    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: EdgeInsets.all(mediaQuery.size.height * .02),
      height: mediaQuery.size.height / 6.8,
      width: double.infinity,
      padding: EdgeInsets.all(mediaQuery.size.height * .024),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 2.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          AutoSizeText(
            'Total:',
            style: TextStyle(
                color: Colors.black, fontSize: mediaQuery.size.height * .03),
          ),
          AutoSizeText(
            oCcy.format(total),
            style: TextStyle(
                color: Colors.black, fontSize: mediaQuery.size.height * .05),
          ),
        ],
      ),
    );
  }
}
